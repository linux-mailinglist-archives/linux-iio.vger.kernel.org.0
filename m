Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE05E588F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 04:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIVC1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 22:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIVC1u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 22:27:50 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB386ABF23
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 19:27:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g2so5343736qkk.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 19:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ty4PinqrzTrMwfXfFSwnwSe5AmVNGOOjp1shLYbbf04=;
        b=Iyhr/gkp1eLOUDpvKWEfkIYzrC45QnnjQGpAKyfT5B5ol/KBYKsO9p8gZyI4X82wps
         HP9Q2D/Brw9YCCUdNo0QTwyFj4gEkIpTMXduYrIz0xg9yXJusw5DcCcbBckUn+F39+jq
         ryi1rfX4I2iY+YhVZ4baeWJSHfJFjWK3XyhOe+VltfnIUuGjizoIYz0tRQ3ggebEBzIp
         ccbRug/n5fNDSlq2WSLBu7c0x1SxjPzU6vCeqefzWjjlMTMaK3tPlhA/cTvMCuSBAUEJ
         RQKOz8/sdXlN0TRuHvP2Xl6hbv5ECtJobb74J4B7xb4nQwxjLoGZ8e2+4f6bTbcUCKXD
         QpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ty4PinqrzTrMwfXfFSwnwSe5AmVNGOOjp1shLYbbf04=;
        b=tZNFU+emnvMsxHH5h6PExgBdjXpu0UwjEafLXrDMxLDuU0RX7AID3U/t0TtQXLPRX0
         mlRiE6ITzNnrQMVwkGStTUbvvzoHQNut16EEOljdy4s/vi/4ocG7R3S9oINI5Vu1pfkq
         sbCJiaQDbHZg7vLgmfV0sTDcQDEOMzu+jZrJSzf70h/6N/n88OThvZmw4Geyq8FMwDxb
         6qyQgLlQ7j9TcgDrUDfF5YGz7c2lo51i5d+m5FcfQQE3OpxHFqPOgE3dh4I352CfNdaw
         lmqM8tlCzucGcC1NtrurcEIicpfMMkcexUzze3xvmo7+d4QI9xwH9gqrmNCNR6duRraQ
         m+Gw==
X-Gm-Message-State: ACrzQf3AfYOy/2zo8yqYWFUftP9BxJQAs6F42frAGjseskOzCVO70qoR
        9hU0eeJRSTe7Qk7R6vGFr576Gw==
X-Google-Smtp-Source: AMsMyM6/mPZWzaV368lIzEXjCUOL5beXwuLjqbU4xesZ3BwBSr8blaMdZAs73XFI/XO8nFukxJ+hlw==
X-Received: by 2002:a05:620a:2683:b0:6cf:3a7e:e006 with SMTP id c3-20020a05620a268300b006cf3a7ee006mr746948qkp.474.1663813666851;
        Wed, 21 Sep 2022 19:27:46 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a449100b006b9264191b5sm3114533qkp.32.2022.09.21.19.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 19:27:46 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:27:44 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v7 2/4] Documentation: ABI: sysfs-bus-counter: add
 frequency & num_overflows items
Message-ID: <YyvIINj7RFy6/LM7@fedora>
References: <20220921100627.124085-1-jpanis@baylibre.com>
 <20220921100627.124085-3-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NhJALy4zGia5d0tl"
Content-Disposition: inline
In-Reply-To: <20220921100627.124085-3-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NhJALy4zGia5d0tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 12:06:25PM +0200, Julien Panis wrote:
> This commit adds frequency and num_overflows items to counter ABI file
> (e.g. for TI ECAP hardware used in capture operating mode).
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 30b6e1faa6f6..aea0adc3938f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -209,6 +209,12 @@ Description:
>  		both edges:
>  			Any state transition.
> =20
> +What:		/sys/bus/counter/devices/counterX/countY/num_overflows
> +KernelVersion:	6.0
> +Contact:	jpanis@baylibre.com
> +Description:
> +		This attribute indicates the number of overflows since count Y start.
> +

Update KernelVersion to "6.1" because that is the next merge target.
Change Contact to "linux-iio@vger.kernel.org" since this ABI is
available for all Counter drivers.

Since num_overflows can be reset, replace the "since count Y start"
phrase with "of Count Y" instead.

>  What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
> @@ -219,11 +225,13 @@ What:		/sys/bus/counter/devices/counterX/countY/pre=
scaler_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_=
id
>  What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component=
_id
> +What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_=
id
>  What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_comp=
onent_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_=
component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_componen=
t_id
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_compon=
ent_id
> +What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
>  KernelVersion:	5.16
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -364,3 +372,9 @@ Description:
>  			via index_polarity. The index function (as enabled via
>  			preset_enable) is performed synchronously with the
>  			quadrature clock on the active level of the index input.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/frequency
> +KernelVersion:	6.0
> +Contact:	jpanis@baylibre.com

Same changes for  KernelVersion and Contact here as above.

William Breathitt Gray

--NhJALy4zGia5d0tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyvIIAAKCRC1SFbKvhIj
K8J1AP9nM1HjVIT1zvrvAVBMEc4rYkWHj+NAJ1xMtA4Ru5vkfAEA61lcnOCUTPhj
Af/9fsODaYA5aTWfpKRD8bln8iVP5QQ=
=N8ey
-----END PGP SIGNATURE-----

--NhJALy4zGia5d0tl--
