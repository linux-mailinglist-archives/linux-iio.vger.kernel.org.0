Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA6144400
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2020 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUSGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jan 2020 13:06:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46511 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUSGQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jan 2020 13:06:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id r9so3733789otp.13;
        Tue, 21 Jan 2020 10:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eEdfR3mTvJ+eThLvVUkTAKC1VIt3ekwfcE55oapGA0g=;
        b=LJQcIRFOFL1henPfN30pYU2blVUjVE4vH+VdIq44x4dlWKs9l5swgiwUyfqg70rfmQ
         lOMXuRzgeviG9XJPgn3KtU3qC41mRE9YZeHgdFsD7pDa6h/C0r1jFy4S9/s7CsGFd2Fx
         P7812fKlVqTQHhCD9+gcjHCG3t7I96CwmBY+IobgizZm+faSDNMAb/QMbJWjr9juzEXW
         2BGwxI690eQnBf6xyYyy1qTd03fd/md1ogMsstpVXkBdObJhw1RR0/apHuaYb99/ZxZH
         i0oLBTUkDcNmK8DDhdWfgM54D7Ubot1haCyJfRTprPvZXfpASXiZmbb58ZlSRnlq88OX
         OSuQ==
X-Gm-Message-State: APjAAAX7yRbJgk0UItqfv9/imaXOn/qxvlpT2X8QO85aS18ZjEEMdUXG
        Kwdj6qzGGlv995RQ/fGKzATR390=
X-Google-Smtp-Source: APXvYqw/nM28s3ODhIW4dDHpgRmOwZrHuAp4V8T6pqn0hoLRvfdTkh3AxUNGHRWFC7FAGupJspgX/w==
X-Received: by 2002:a9d:6849:: with SMTP id c9mr4766302oto.206.1579629975441;
        Tue, 21 Jan 2020 10:06:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm13698624otl.74.2020.01.21.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:06:14 -0800 (PST)
Received: (nullmailer pid 10136 invoked by uid 1000);
        Tue, 21 Jan 2020 18:06:14 -0000
Date:   Tue, 21 Jan 2020 12:06:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ekigwana@gmail.com, jic23@kernel.org,
        lars@metafoo.de, Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: frequency: Add docs for ADF4360 PLL
Message-ID: <20200121180614.GA9314@bogus>
References: <20200121112556.9867-1-alexandru.ardelean@analog.com>
 <20200121112556.9867-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121112556.9867-2-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jan 2020 13:25:55 +0200, Alexandru Ardelean wrote:
> From: Edward Kigwana <ekigwana@gmail.com>
> 
> This change adds the device-tree bindings documentation for the ADF4360
> family of PLLs.
> 
> Signed-off-by: Edward Kigwana <ekigwana@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4360.yaml   | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml:  while scanning a simple key
  in "<unicode string>", line 98, column 5
could not find expected ':'
  in "<unicode string>", line 99, column 5
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/iio/frequency/adi,adf4360.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/iio/frequency/adi,adf4360.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1226401
Please check and re-submit.
