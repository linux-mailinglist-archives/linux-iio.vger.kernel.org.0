Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8166DD2ED6
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfJJQsx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 12:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJJQsx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Oct 2019 12:48:53 -0400
Received: from earth.universe (tmo-080-106.customers.d1-online.com [80.187.80.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BF6218AC;
        Thu, 10 Oct 2019 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570726131;
        bh=CIYAHbrsHehDhmC0lEz5QCXbhpUiDbqLb2gCs6WSC9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPr9a1pE8sZmfRWug8YooAsGNOcCWMRytUoxhQwNsZE29Jef4wv1zF90wnJ7kuIQx
         iWMsPt3LLGLLjt/K4MV65uLw4ajdEuIHa5S6wKZbThMUII5ERwnhrMLnbBzgw2bT2b
         pDfQXm/V146Zqxin4fVe3wjvoVzW+bqg8q8LXHwc=
Received: by earth.universe (Postfix, from userid 1000)
        id 57D1D3C0CA2; Thu, 10 Oct 2019 18:48:47 +0200 (CEST)
Date:   Thu, 10 Oct 2019 18:48:47 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: samsung: Indent examples with four
 spaces
Message-ID: <20191010164847.ntbhecap6pbesvk7@earth.universe>
References: <20191002160744.11307-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="us5fnkoji2afabie"
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-1-krzk@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--us5fnkoji2afabie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 02, 2019 at 06:07:41PM +0200, Krzysztof Kozlowski wrote:
> Change the indentation of examples used in json-schema bindings from two
> to four spaces as this makes the code easier to read and seems to be
> preferred in other files.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Sebastian Reichel <sre@kernel.org> # for power/reset

-- Sebastian

> ---
>  .../bindings/arm/samsung/exynos-chipid.yaml   |  4 +-
>  .../bindings/iio/adc/samsung,exynos-adc.yaml  | 64 +++++++++----------
>  .../bindings/power/reset/syscon-poweroff.yaml |  8 +--
>  .../bindings/power/reset/syscon-reboot.yaml   |  8 +--
>  .../devicetree/bindings/rtc/s3c-rtc.yaml      | 12 ++--
>  5 files changed, 48 insertions(+), 48 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.=
yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> index 9c573ad7dc7d..ce40adabb4e8 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> @@ -20,6 +20,6 @@ properties:
>  examples:
>    - |
>      chipid@10000000 {
> -      compatible =3D "samsung,exynos4210-chipid";
> -      reg =3D <0x10000000 0x100>;
> +        compatible =3D "samsung,exynos4210-chipid";
> +        reg =3D <0x10000000 0x100>;
>      };
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc=
=2Eyaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index b4c6c26681d9..a0a9b909ac40 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -112,40 +112,40 @@ allOf:
>  examples:
>    - |
>      adc: adc@12d10000 {
> -      compatible =3D "samsung,exynos-adc-v1";
> -      reg =3D <0x12d10000 0x100>;
> -      interrupts =3D <0 106 0>;
> -      #io-channel-cells =3D <1>;
> -      io-channel-ranges;
> -
> -      clocks =3D <&clock 303>;
> -      clock-names =3D "adc";
> -
> -      vdd-supply =3D <&buck5_reg>;
> -      samsung,syscon-phandle =3D <&pmu_system_controller>;
> -
> -      /* NTC thermistor is a hwmon device */
> -      ncp15wb473@0 {
> -        compatible =3D "murata,ncp15wb473";
> -        pullup-uv =3D <1800000>;
> -        pullup-ohm =3D <47000>;
> -        pulldown-ohm =3D <0>;
> -        io-channels =3D <&adc 4>;
> -      };
> +        compatible =3D "samsung,exynos-adc-v1";
> +        reg =3D <0x12d10000 0x100>;
> +        interrupts =3D <0 106 0>;
> +        #io-channel-cells =3D <1>;
> +        io-channel-ranges;
> +
> +        clocks =3D <&clock 303>;
> +        clock-names =3D "adc";
> +
> +        vdd-supply =3D <&buck5_reg>;
> +        samsung,syscon-phandle =3D <&pmu_system_controller>;
> +
> +        /* NTC thermistor is a hwmon device */
> +        ncp15wb473@0 {
> +            compatible =3D "murata,ncp15wb473";
> +            pullup-uv =3D <1800000>;
> +            pullup-ohm =3D <47000>;
> +            pulldown-ohm =3D <0>;
> +            io-channels =3D <&adc 4>;
> +          };
>      };
> =20
>    - |
>      adc@126c0000 {
> -      compatible =3D "samsung,exynos3250-adc";
> -      reg =3D <0x126C0000 0x100>;
> -      interrupts =3D <0 137 0>;
> -      #io-channel-cells =3D <1>;
> -      io-channel-ranges;
> -
> -      clocks =3D <&cmu 0>, // CLK_TSADC
> -               <&cmu 1>; // CLK_SCLK_TSADC
> -      clock-names =3D "adc", "sclk";
> -
> -      vdd-supply =3D <&buck5_reg>;
> -      samsung,syscon-phandle =3D <&pmu_system_controller>;
> +        compatible =3D "samsung,exynos3250-adc";
> +        reg =3D <0x126C0000 0x100>;
> +        interrupts =3D <0 137 0>;
> +        #io-channel-cells =3D <1>;
> +        io-channel-ranges;
> +
> +        clocks =3D <&cmu 0>, // CLK_TSADC
> +                 <&cmu 1>; // CLK_SCLK_TSADC
> +        clock-names =3D "adc", "sclk";
> +
> +        vdd-supply =3D <&buck5_reg>;
> +        samsung,syscon-phandle =3D <&pmu_system_controller>;
>      };
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-powerof=
f.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> index fb812937b534..520e07e6f21b 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
> @@ -53,8 +53,8 @@ allOf:
>  examples:
>    - |
>      poweroff {
> -      compatible =3D "syscon-poweroff";
> -      regmap =3D <&regmapnode>;
> -      offset =3D <0x0>;
> -      mask =3D <0x7a>;
> +        compatible =3D "syscon-poweroff";
> +        regmap =3D <&regmapnode>;
> +        offset =3D <0x0>;
> +        mask =3D <0x7a>;
>      };
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.=
yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> index a7920f5eef79..d38006b1f1f4 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> @@ -53,8 +53,8 @@ allOf:
>  examples:
>    - |
>      reboot {
> -      compatible =3D "syscon-reboot";
> -      regmap =3D <&regmapnode>;
> -      offset =3D <0x0>;
> -      mask =3D <0x1>;
> +        compatible =3D "syscon-reboot";
> +        regmap =3D <&regmapnode>;
> +        offset =3D <0x0>;
> +        mask =3D <0x1>;
>      };
> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documen=
tation/devicetree/bindings/rtc/s3c-rtc.yaml
> index 951a6a485709..95570d7e19eb 100644
> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
> @@ -76,10 +76,10 @@ allOf:
>  examples:
>    - |
>      rtc@10070000 {
> -      compatible =3D "samsung,s3c6410-rtc";
> -      reg =3D <0x10070000 0x100>;
> -      interrupts =3D <0 44 4>, <0 45 4>;
> -      clocks =3D <&clock 0>, // CLK_RTC
> -               <&s2mps11_osc 0>; // S2MPS11_CLK_AP
> -      clock-names =3D "rtc", "rtc_src";
> +        compatible =3D "samsung,s3c6410-rtc";
> +        reg =3D <0x10070000 0x100>;
> +        interrupts =3D <0 44 4>, <0 45 4>;
> +        clocks =3D <&clock 0>, // CLK_RTC
> +                 <&s2mps11_osc 0>; // S2MPS11_CLK_AP
> +        clock-names =3D "rtc", "rtc_src";
>      };
> --=20
> 2.17.1
>=20

--us5fnkoji2afabie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2fYOwACgkQ2O7X88g7
+ppSrg//bVatCCeRxdy3A8zBUf1L3vjwbU/1yfhQsQDeUnYJ+HvG3pebohHnDXXj
VGg/bTCDnD8PT9wRFI78GC2GDhYhi3XQpntuKVvtCuwGWoI4FqFZDyJ8X1A6kRSi
PtQHqaYLaBaq4glfLaXmmJfbYq+lnMAZzJzJfPYSBfe3dAvj7YwMM7C+i6VLD68c
hyDKiCqqHb2JqH9C6j3i8eiLfmmodhYapdfCace5V1xCO3Usd52gxta+XxDf+YBm
dc3DVL8qg+8GRlGinNWXhpv5GrKV4CTJuJYpHydE2P85PY5/Q3gnLGn/I1lHaxH5
/pd9HAoRnIF26bX5hwrH4kI0wt3QAr83sttQo5GRljN09BkGyCgmJOdoq/d/ar8H
2UKKGFPeERuBkii6jQoCx12oKHjnOw9PMEPa9o7Yvs1Y7qjDVujLPojonG7k9+JU
cU1LfJP482TWwtWBOjy2RlslEWKWzwswuPpk2y05ufwxXE32CCjyXYudOLcBOQPU
Ucio2laTAkwAIkKRav9HILRm1ihrAp6SHQMpcALQWf/a8aZYe8MLWo/axy4gLna2
jh/COFBA+feof+MBzlAqoVVtzriiuK6ehlX8PcuIzMYFfbxCaGX1oO3zDXecLezb
5Oahbja8sKKws7/GufvZtbhr/aOkK34qZErnLyGas/Mm/CpChmI=
=xmZh
-----END PGP SIGNATURE-----

--us5fnkoji2afabie--
