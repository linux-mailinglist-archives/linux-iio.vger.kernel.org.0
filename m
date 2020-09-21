Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88BC2720E0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 12:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIUK0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 06:26:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:47932 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgIUK0d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 06:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References; bh=eY5LxhM6IJXQOEyzRVkGoUrgdQjhHHpcbF1poDzsPBM=; b=RA
        WEgFaiQszqIaRDOHbVrTmToqeRnfTk7KGnA+91nLzMZ7+YFtiH/+iqGDtW6pFVy0kC5bg5RfapKLw
        xnQEMh1iqOxbbzJD6ILo11/nyBnNWmucCgbvqkWseWesFvG/x04INBMOave5HvTKA5UN0A/8KNmOo
        8/RmU/vmZe6yreq+qJJ2zw0HC5aiZt/rWOv02AEc60E6N2FhiGm0TszktsgJ/6z30CnLmn/YcjdA4
        SB1BE+EW3FQFbHQzsLCGt7BPwzjLcsGKW7QVxTH5zvrI/Q40iWiGTeM32JVHntt8AFPWVzOB17W+n
        M3JqmR8nkxldPF4ck64gfjnr28TT74FQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kKJ1j-00018S-Nx; Mon, 21 Sep 2020 12:26:32 +0200
Received: from [2001:a61:259b:1201:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kKJ1j-0005fe-GC; Mon, 21 Sep 2020 12:26:31 +0200
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Subject: yaml schema and sub-nodes with vendor prefixes
Message-ID: <b665f17d-0029-b51b-ac09-597f7b26d77b@metafoo.de>
Date:   Mon, 21 Sep 2020 12:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25933/Sun Sep 20 15:50:34 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I'm trying to convert Xilinx XADC devicetree bindings[1] description to 
yaml format. And I'm running into issue with describing a sub-node with 
a vendor prefix.

A typical devicetree entry for the XADC looks like

     xadc@43200000 {
         compatible = "xlnx,axi-xadc-1.00.a";

         xlnx,channels {
             #address-cells = <1>;
             #size-cells = <0>;
             channel@0 {
                 reg = <0>;
                 xlnx,bipolar;
             };
         };
     };

So there is the 'xlnx,channels' sub-node which contains a set of other 
nodes which represent the individual channels.

The way I'm trying to describe it in the yaml file is like

  xlnx,channels:
     description: Node containing all the channel nodes
     type: object
     properties:
       '#address-cells':
          const: 1
       '#size-cells':
          const: 0

     patternProperties:
       "^channel@([0-9]|1[0-6])$":
         type: object
         properties:
           reg:
             description: ...
           xlnx,bipolar:
             description: If set the channel is used in bipolar mode.
             type: boolean
         required:
           - reg
         additionalProperties: false

     required:
       - '#address-cells'
       - '#size-cells'
     additionalProperties: false

This now fails validation, presumably because there is no match in 
meta-schemas/vendor-props.yaml. If I drop the vendor prefix from the 
property name validation passes. I can also make validation pass by 
adding an arbitrary $ref property, but there is no 'node' type in 
types.yaml.

What's the best way to describe a node with a vendor prefix?

Thanks,

- Lars

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt

