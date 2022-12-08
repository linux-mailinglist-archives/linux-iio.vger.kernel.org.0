Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93440646A12
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLHIEq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 03:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLHIEq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 03:04:46 -0500
X-Greylist: delayed 1371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Dec 2022 00:04:43 PST
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3554B11;
        Thu,  8 Dec 2022 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:
        To:From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=bml85ulkX1OS7ktufGeEH5m2m20WMjZxds4C1n9NNvE=; b=0Ri+ER
        OEJlmXFJNut++pB2ojG0rki4S+bI/Qi4YGmVFGjkDCL286qKdzTarTTl22oX1pBfmqiaAqCms8cva
        t4Q+twRSBkEFI3I4LfJWTGAn0Yxrtx6EX+hW6406wBTH5PkASqgvS3OUmQISeCTOuG8QVXEEGTM4r
        nHobeimVyDa21tWy/kGFmdI9SPLL6k2KUtyFaL/r/7Z1Sq9kAgpmM02Aa56UPmtq1YIlQzSjDGD0L
        nEr+IxY58i2LZSWsxO7FyX/Twg9SucnV8qYVWnJDYPoCU59Vd+w/urjis3Z2zyBNYcZjCrndw/nmT
        iV8UTI1XakG1RLNLPRIhLenRyYBA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1p3BXh-000MKT-4s; Thu, 08 Dec 2022 08:42:05 +0100
Received: from [192.168.0.30] (helo=webmail.your-server.de)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1p3BXg-000L7Y-QG; Thu, 08 Dec 2022 08:42:04 +0100
Received: from 2a06.4004.10DF.0001.15d4.557d.AD03.f652.static6.kviknet.net
 (2a06.4004.10DF.0001.15d4.557d.AD03.f652.static6.kviknet.net
 [2a06:4004:10df:1:15d4:557d:ad03:f652]) by webmail.your-server.de (Horde
 Framework) with HTTPS; Thu, 08 Dec 2022 08:42:04 +0100
Date:   Thu, 08 Dec 2022 08:42:04 +0100
Message-ID: <20221208084204.Horde.i2WEsn4JH4SC4PwvZd8m7xF@webmail.your-server.de>
From:   sean@geanix.com
To:     Han Xu <han.xu@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH 2/2] dt-bindings: iio: accel: fxls8962af: add new
 compatible string
References: <20221207162045.669958-1-han.xu@nxp.com>
 <20221207162045.669958-2-han.xu@nxp.com>
In-Reply-To: <20221207162045.669958-2-han.xu@nxp.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.7/26743/Wed Dec  7 09:17:04 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Quoting Han Xu <han.xu@nxp.com>:

> add new compatible string for the NXP FXLS8967AF accelerometer sensor.
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git  
> a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml  
> b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index 65ce8ea14b52..400eff3ff315 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -14,12 +14,14 @@ description: |
>    SPI and I2C interface.
>      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
>
>  properties:
>    compatible:
>      enum:
>        - nxp,fxls8962af
>        - nxp,fxls8964af
> +      - nxp,fxls8967af
>
>    reg:
>      maxItems: 1
> --
> 2.25.1



