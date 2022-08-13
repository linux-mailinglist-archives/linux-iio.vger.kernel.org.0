Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAA591D11
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiHMWrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 18:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiHMWrV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 18:47:21 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B957472842
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:47:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s11so3226774qtx.6
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=9LFLBJaya1h09m2Uy33ayjw6aK7QAV0Ax/8vkX3cn+s=;
        b=E2sMdmSZeqX6vDy6vAuqauLIjYQ7VjfdsxyB75VdTqRZ83V+6iyp7VuvJnSh3eMWBN
         kB+ahjW80Wl3+HTEEqi7vRgXu6orLrJJ/nLJgX35SGFaDeFJJISHlQFIonSNC8+Gf6RE
         iV0BCxq24IPh0pA/B33geDauQSjynNaUkjVZlpDNuHV7ckFM8nyhAS1Y1JCaWgWJoRST
         mro0JpilWNSNgIlilACajSgm8oOLwVLNPyYSwaSFY+luy01n+TJib4bTNpYfqb6O3qMm
         MZSUTGgbs6UsVUUAezGpJTIMgu9maBAkQVNge6A57cE2WLSqFPO5P3MpYgWdIFpOE/1C
         eWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9LFLBJaya1h09m2Uy33ayjw6aK7QAV0Ax/8vkX3cn+s=;
        b=Q/oyY0ZrJuWV4+h6o6RsM6Cl673EvLsfX/1lCoqt/PJNU/udz85/MDRTIWZN2NuBTD
         bt25IiMQVl8E8MQ97zzmgBdFz0LcfRmoGPdQmkovi4Utc8M8npLNDRUk/1w8cPmdIGWe
         B7hnRkmfcBG9VpBmJeGi62f/s/nhzorBXQa3ybaMdxlt1rNtnKsfE73RGG7ZQPmwqsfx
         N9hDk+NWL9jEd+a2t9GHSl59ars4JKv6XiXlLuZbpVfrj4PMyKlh7zDqQ2a7QBc+gfF5
         dqgtIrV6GEi9iGPSPw8fLfdqsRrt82NWcoSE6gyGuALcYeYOf1UwiFUH7y6AEfbEb61a
         xVfg==
X-Gm-Message-State: ACgBeo36EYQ0PeQWenHdtxFRW5953e4XzdYAHMK1qdg308KX2nyaPl4V
        K8y2DZbBujPIUz3vYldPhPnKYQ==
X-Google-Smtp-Source: AA6agR5Tfq6TPQUxc+yP0HMrhhSRR875Ule/igBA2OayHC6AArFEzuS79M7WPDhU/j/ysxONb6yCWQ==
X-Received: by 2002:a05:622a:1c3:b0:344:56b5:f14b with SMTP id t3-20020a05622a01c300b0034456b5f14bmr442813qtw.152.1660430839835;
        Sat, 13 Aug 2022 15:47:19 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b006aee5df383csm4777866qkg.134.2022.08.13.15.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 15:47:19 -0700 (PDT)
Date:   Sat, 13 Aug 2022 18:47:17 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v4 2/3] Documentation: ABI: add sysfs-bus-counter-ecap
Message-ID: <Yvgp9WGcA2fqS1Rm@fedora>
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-3-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+ComDZuVIk5knoa"
Content-Disposition: inline
In-Reply-To: <20220810140724.182389-3-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--R+ComDZuVIk5knoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 04:07:23PM +0200, Julien Panis wrote:
> This commit adds an ABI file for TI ECAP used in capture operating mode.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Hi Julien,

Duplicate ABIs are no longer valid, so we consolidated the Counter sysfs
attributes documentation to a single sysfs-bus-counter file in commit
769841c966fd. You can document the new sysfs attributes you introduce
for the TI eCAP counter driver to that sysfs-bus-counter file as well.

William Breathitt Gray

> ---
>  .../ABI/testing/sysfs-bus-counter-ecap        | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ecap
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ecap b/Documenta=
tion/ABI/testing/sysfs-bus-counter-ecap
> new file mode 100644
> index 000000000000..ca530a6806de
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-ecap
> @@ -0,0 +1,64 @@
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity1
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity2
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity3
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity4
> +KernelVersion:	5.19
> +Contact:	jpanis@baylibre.com
> +Description:
> +		ECAP module includes 4 timestamp capture registers.
> +		For all 4 sequenced timestamp capture events (1->2->3->4->1->...),
> +		edge polarity can be selected. Then, each capture register can be
> +		tuned to capture event by either:
> +
> +		- "rising"
> +		- "falling"
> +
> +		Reading returns current trigger polarity.
> +
> +		Writing value before enabling capture sets trigger polarity.
> +
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity1_available
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity2_available
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity3_available
> +What:		/sys/bus/counter/devices/counter0/signal0/polarity4_available
> +KernelVersion:	5.19
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Discrete set of available values for the respective polarity X
> +		configuration are listed in this file. Values are delimited by
> +		newline characters.
> +
> +What:		/sys/bus/counter/devices/counter0/count0/enable
> +KernelVersion:	5.19
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Whether ECAP is enabled. Valid attribute values are boolean.
> +
> +		This attribute is intended to serve as a start/stop mechanism
> +		for ECAP.
> +
> +What:		/sys/bus/counter/devices/counter0/count0/count
> +KernelVersion:	5.19
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Read-only attribute that indicates the current base counter value.
> +
> +What:		/sys/bus/counter/devices/counter0/count0/capture1
> +What:		/sys/bus/counter/devices/counter0/count0/capture2
> +What:		/sys/bus/counter/devices/counter0/count0/capture3
> +What:		/sys/bus/counter/devices/counter0/count0/capture4
> +KernelVersion:	5.19
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Read-only attributes that indicate the last timestamp captured
> +		for the respective capture X register.
> +
> +What:		/sys/bus/counter/devices/counter0/count0/capture1_component_id
> +What:		/sys/bus/counter/devices/counter0/count0/capture2_component_id
> +What:		/sys/bus/counter/devices/counter0/count0/capture3_component_id
> +What:		/sys/bus/counter/devices/counter0/count0/capture4_component_id
> +KernelVersion:	5.19
> +Contact:	jpanis@baylibre.com
> +Description:
> +		Read-only attributes that indicate the component ID of the
> +		respective extension or synapse.
> --=20
> 2.25.1
>=20

--R+ComDZuVIk5knoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvgp9QAKCRC1SFbKvhIj
K+hOAP9FJPw/AbXZbCmP3t4cfCY2o6AER5KkmaxTEu0mFDAafwEApCOn+i40k5FZ
CqEdQohSPhKXNuCBLsp8BBgdR1MLZQg=
=jfdg
-----END PGP SIGNATURE-----

--R+ComDZuVIk5knoa--
