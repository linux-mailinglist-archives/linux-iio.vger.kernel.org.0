Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC315183A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 10:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgBDJxC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 04:53:02 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:30338 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgBDJxC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 04:53:02 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48Bg3v0vD9z81;
        Tue,  4 Feb 2020 10:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1580809980; bh=Wfx9Ic8gyTGpTUa8i8tQhhpCrvguesyJAkcQP3qscl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4G/k010+cXgdDhVdzgY1r1bMv85CTdNsUKgPQm5zj4BPFWLdrAccy6C08l1tB9D7
         bnut/ZHtL1se93rH3kSWt8qPpsVDhXHvrI6HxVB6O+RKMBJbZ6AOrCeOMHRxsEPExj
         2JMrElsKFfMtrTufLo5cDUBEQhkaSQKJdacUM4i84QI3wGs2BcONw9EDAjV48z7GZz
         vbB7Upnc37svn2ckJ7n0kDXiFLWZnILKwbFHMggbeJcbcGRotVkaa0qO++hwEBjWCe
         fiRQl8ciLkIp2wtHl3LaDyp6CSMY0ZwyUto5K9zQ/D4QIK7dMiTWbnbBxKDcwzOk9F
         CsaCpI8/Tl8/A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 4 Feb 2020 10:52:57 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
Message-ID: <20200204095257.GA23609@qmqm.qmqm.pl>
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-3-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200204093031.616409-3-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 04, 2020 at 10:30:30AM +0100, David Heidelberg wrote:
> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
> provides a multiple gain function with linear response over a dynamic
> range 1216/4863/19452/77806.
[...]
> +properties:
> +  compatible:
> +    const: dynaimage,al3010
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply

Regulator and interrupt should be optional.

Best Regards,
Micha³ Miros³aw
