Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE092A2F9B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 17:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKBQUu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 11:20:50 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.158]:50978 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgKBQUt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 11:20:49 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.22.175
X-Interia-R-Helo: <t480s.localdomain>
Received: from t480s.localdomain (ipv4-188-121-22-175.net.internetunion.pl [188.121.22.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Mon,  2 Nov 2020 17:13:29 +0100 (CET)
Date:   Mon, 2 Nov 2020 17:13:27 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/7] dt-bindings:iio:potentiometer:maxim,ds1803 move to
 trivial devices.
Message-ID: <20201102161327.GA524499@t480s.localdomain>
References: <20201031182922.743153-1-jic23@kernel.org>
 <20201031182922.743153-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201031182922.743153-4-jic23@kernel.org>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1604333610;
        bh=OIF1bflcfVyHLkclBmZ065/HILvPFrrH1PZ51YuU04Q=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-Interia-Antivirus;
        b=fIy+Nd9A41/9HLi+LXhIN4urMZfwtUwmkKHNZsCX/wtXzhYyiQoM2UcwQ6b194XNQ
         NwaatdtNgXGjDssLzF1wMuovUiyuKTycRZ3HFEmnQ/8BKuiyOOh9KGsSmZalVOEb5K
         qGbZ6L4n+wtYfhailMpeeAyGT4AchHirblmRGm0w=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On paź 31, 2020 18:29, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding where there is no obvious benefit in maintaining a
> separate file.  Hence document in trivial-devices.yaml and drop
> the txt file.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Slawomir Stepien <sst@poczta.fm>

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

> ---
>  .../bindings/iio/potentiometer/ds1803.txt     | 21 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  6 ++++++
>  2 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt b/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
> deleted file mode 100644
> index df77bf552656..000000000000
> --- a/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* Maxim Integrated DS1803 digital potentiometer driver
> -
> -The node for this driver must be a child node of a I2C controller, hence
> -all mandatory properties for your controller must be specified. See directory:
> -
> -        Documentation/devicetree/bindings/i2c
> -
> -for more details.
> -
> -Required properties:
> -	- compatible:  	Must be one of the following, depending on the
> -			model:
> -			"maxim,ds1803-010",
> -			"maxim,ds1803-050",
> -			"maxim,ds1803-100"
> -
> -Example:
> -ds1803: ds1803@1 {
> -	reg = <0x28>;
> -	compatible = "maxim,ds1803-010";
> -};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 10f0afd44684..695b1e379238 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -110,6 +110,12 @@ properties:
>            - isil,isl68137
>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
> +            # 10 kOhm digital potentiometer with I2C interface
> +          - maxim,ds1803-010
> +            # 50 kOhm digital potentiometer with I2C interface
> +          - maxim,ds1803-050
> +            # 100 kOhm digital potentiometer with I2C interface
> +          - maxim,ds1803-100
>              # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>            - maxim,max1237
>              # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion

-- 
Slawomir Stepien
