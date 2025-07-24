Return-Path: <linux-iio+bounces-21958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D14B1092A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A623BABB4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B337271A94;
	Thu, 24 Jul 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PESIvLOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E892701DA;
	Thu, 24 Jul 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356497; cv=none; b=F37KNs5Ao0iUho8kBho/7u9DSyYQANlqtQ5tdKdVZh/4YsCUrFlF5YTmU5JAyOgAvbuAqWAmEj3LM9Bm++VU2T42i677vQTdtfNJK9VRaO9dkF2F56OWcWDBE2CmUbZ/bLg3LGEbC7q5FfAMAhxIrSgAEe3kzXefmZQQKBz24YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356497; c=relaxed/simple;
	bh=dxI+/4zumLVFOrfjuxZXLvotdarsWSE+MJn9iLy7KUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwl33bDmn6qgrg/iB9FfU83IgUn3YOi+ZJTMxUatkbc4Eej2rzvuB0Ly+fXPbOwpBfBUcnxgeZwmkDu+NiEs/JaFIyGIpK+L+dNvAqBsGt0omFtMpjXWrsQJVpmMrBrfZOFu5jT/jODU8X6eHTpSdVJ83VZ7AgQzWHTEBjiAuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PESIvLOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E6C4CEED;
	Thu, 24 Jul 2025 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753356497;
	bh=dxI+/4zumLVFOrfjuxZXLvotdarsWSE+MJn9iLy7KUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PESIvLOb2BswDZyzn3ghE6QRLz6u37ETWPTxxhleowkA49P24Bn9zFyUHq7BDwR1r
	 7mASsjY5nY/EtM2jttJVYG1h4AqkVoo+MFf7HloEiyUb6ft/Pe0fsWnGjFfVo0pECP
	 uA4B0uCLGqLHAcEhG2LW7rD5FyAdrmUdZEsapaQGx6XZgLvebAIOg6mICZr53i2iLA
	 X1ESQaoBBURrHejaNeQJy95unl8psK+5svSupl9hS/ig7Wuj5flVijZYKx9PISiXEE
	 +6RJdzRI4bn3/pnCW/jhf+xwGROtSqGqnBB18c66iZ0Ns1AqS6hFrX/rmDBMlU4wLS
	 8W591rD+/t4qQ==
Date: Thu, 24 Jul 2025 12:28:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7280a: Remove unused macros
Message-ID: <20250724122809.11971471@jic23-huawei>
In-Reply-To: <5j6qcum4oi4cgnzplmnd4xqx2aothhqpk5votscc6v56xdnlwa@gt6x3ugjyr45>
References: <aIIQ3xxCNfpTouxQ@pc>
	<5j6qcum4oi4cgnzplmnd4xqx2aothhqpk5votscc6v56xdnlwa@gt6x3ugjyr45>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 12:06:20 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, Jul 24, 2025 at 11:54:23AM +0100, Salah Triki wrote:
> > This is to fix the following warnings when compiling the ad7280a driver=
 using
> > LLVM=3D1 and W=3D2:
> >=20
> > drivers/iio/adc/ad7280a.c:60:13: warning: macro is not used [-Wunused-m=
acros]
> >    60 | #define     AD7280A_CTRL_HB_CONV_AVG_4                         =
 2
> >       |             ^
> > drivers/iio/adc/ad7280a.c:97:9: warning: macro is not used [-Wunused-ma=
cros]
> >    97 | #define AD7280A_CB4_TIMER_REG                   0x18 /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:120:9: warning: macro is not used [-Wunused-m=
acros]
> >   120 | #define AD7280A_TRANS_READ_CRC_MSK              GENMASK(9, 2)
> >       |         ^
> > drivers/iio/adc/ad7280a.c:33:9: warning: macro is not used [-Wunused-ma=
cros]
> >    33 | #define AD7280A_CELL_VOLTAGE_5_REG              0x4  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:99:9: warning: macro is not used [-Wunused-ma=
cros]
> >    99 | #define AD7280A_CB6_TIMER_REG                   0x1A /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:30:9: warning: macro is not used [-Wunused-ma=
cros]
> >    30 | #define AD7280A_CELL_VOLTAGE_2_REG              0x1  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:52:13: warning: macro is not used [-Wunused-m=
acros]
> >    52 | #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL                   =
 2
> >       |             ^
> > drivers/iio/adc/ad7280a.c:58:13: warning: macro is not used [-Wunused-m=
acros]
> >    58 | #define     AD7280A_CTRL_HB_CONV_AVG_DIS                       =
 0
> >       |             ^
> > drivers/iio/adc/ad7280a.c:59:13: warning: macro is not used [-Wunused-m=
acros]
> >    59 | #define     AD7280A_CTRL_HB_CONV_AVG_2                         =
 1
> >       |             ^
> > drivers/iio/adc/ad7280a.c:46:13: warning: macro is not used [-Wunused-m=
acros]
> >    46 | #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5          =
 1
> >       |             ^
> > drivers/iio/adc/ad7280a.c:37:9: warning: macro is not used [-Wunused-ma=
cros]
> >    37 | #define AD7280A_AUX_ADC_3_REG                   0x8  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:39:9: warning: macro is not used [-Wunused-ma=
cros]
> >    39 | #define AD7280A_AUX_ADC_5_REG                   0xA  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:32:9: warning: macro is not used [-Wunused-ma=
cros]
> >    32 | #define AD7280A_CELL_VOLTAGE_4_REG              0x3  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:41:9: warning: macro is not used [-Wunused-ma=
cros]
> >    41 | #define AD7280A_SELF_TEST_REG                   0xC  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:96:9: warning: macro is not used [-Wunused-ma=
cros]
> >    96 | #define AD7280A_CB3_TIMER_REG                   0x17 /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:98:9: warning: macro is not used [-Wunused-ma=
cros]
> >    98 | #define AD7280A_CB5_TIMER_REG                   0x19 /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:85:13: warning: macro is not used [-Wunused-m=
acros]
> >    85 | #define     AD7280A_ALERT_REMOVE_AUX3_AUX5              BIT(1)
> >       |             ^
> > drivers/iio/adc/ad7280a.c:138:9: warning: macro is not used [-Wunused-m=
acros]
> >   138 | #define AD7280A_DEVADDR_ALL             0x1F
> >       |         ^
> > drivers/iio/adc/ad7280a.c:100:9: warning: macro is not used [-Wunused-m=
acros]
> >   100 | #define AD7280A_PD_TIMER_REG                    0x1B /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:74:11: warning: macro is not used [-Wunused-m=
acros]
> >    74 | #define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK              BIT(1)
> >       |           ^
> > drivers/iio/adc/ad7280a.c:61:13: warning: macro is not used [-Wunused-m=
acros]
> >    61 | #define     AD7280A_CTRL_HB_CONV_AVG_8                         =
 3
> >       |             ^
> > drivers/iio/adc/ad7280a.c:31:9: warning: macro is not used [-Wunused-ma=
cros]
> >    31 | #define AD7280A_CELL_VOLTAGE_3_REG              0x2  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:51:13: warning: macro is not used [-Wunused-m=
acros]
> >    51 | #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5          =
 1
> >       |             ^
> > drivers/iio/adc/ad7280a.c:47:13: warning: macro is not used [-Wunused-m=
acros]
> >    47 | #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL                   =
 2
> >       |             ^
> > drivers/iio/adc/ad7280a.c:84:13: warning: macro is not used [-Wunused-m=
acros]
> >    84 | #define     AD7280A_ALERT_REMOVE_AUX5                   BIT(0)
> >       |             ^
> > drivers/iio/adc/ad7280a.c:103:9: warning: macro is not used [-Wunused-m=
acros]
> >   103 | #define AD7280A_CNVST_CTRL_REG                  0x1D /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:55:13: warning: macro is not used [-Wunused-m=
acros]
> >    55 | #define     AD7280A_CTRL_HB_CONV_START_CNVST                   =
 0
> >       |             ^
> > drivers/iio/adc/ad7280a.c:36:9: warning: macro is not used [-Wunused-ma=
cros]
> >    36 | #define AD7280A_AUX_ADC_2_REG                   0x7  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:119:9: warning: macro is not used [-Wunused-m=
acros]
> >   119 | #define AD7280A_TRANS_READ_WRITE_ACK_MSK        BIT(10)
> >       |         ^
> > drivers/iio/adc/ad7280a.c:38:9: warning: macro is not used [-Wunused-ma=
cros]
> >    38 | #define AD7280A_AUX_ADC_4_REG                   0x9  /* D11 to =
D0, Read only */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:95:9: warning: macro is not used [-Wunused-ma=
cros]
> >    95 | #define AD7280A_CB2_TIMER_REG                   0x16 /* D7 to D=
0, Read/write */
> >       |         ^
> > drivers/iio/adc/ad7280a.c:48:13: warning: macro is not used [-Wunused-m=
acros]
> >    48 | #define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST               =
 3
> >       |             ^
> >  =20
>=20
> Please crop the commit message. No need to past all the compiler output
> to make your point valid. This bloats the commit message a lot :)
>=20
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > --- =20
>=20
> Some people do like to have all of the register map defined even if not
> used. I personally don't... So, with the commit message improved:

I take the view this is up to a driver submitter when it comes to register
maps.  As such I'd rather we didn't go dropping these.
This is particularly true when it results in a partial register definition
which some of these do.

Building with W=3D2 is optimistic :)  I want IIO to be W=3D1 clean but
stuff gets stuck under there (like the exports.h missing include thing)
because they are annoying to normal people!

Jonathan

>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> >  drivers/iio/adc/ad7280a.c | 32 --------------------------------
> >  1 file changed, 32 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> > index dda2986ccda0..cf2d70c959b3 100644
> > --- a/drivers/iio/adc/ad7280a.c
> > +++ b/drivers/iio/adc/ad7280a.c
> > @@ -27,38 +27,19 @@
> >  /* Registers */
> > =20
> >  #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> > -#define AD7280A_CELL_VOLTAGE_2_REG		0x1  /* D11 to D0, Read only */
> > -#define AD7280A_CELL_VOLTAGE_3_REG		0x2  /* D11 to D0, Read only */
> > -#define AD7280A_CELL_VOLTAGE_4_REG		0x3  /* D11 to D0, Read only */
> > -#define AD7280A_CELL_VOLTAGE_5_REG		0x4  /* D11 to D0, Read only */
> >  #define AD7280A_CELL_VOLTAGE_6_REG		0x5  /* D11 to D0, Read only */
> >  #define AD7280A_AUX_ADC_1_REG			0x6  /* D11 to D0, Read only */
> > -#define AD7280A_AUX_ADC_2_REG			0x7  /* D11 to D0, Read only */
> > -#define AD7280A_AUX_ADC_3_REG			0x8  /* D11 to D0, Read only */
> > -#define AD7280A_AUX_ADC_4_REG			0x9  /* D11 to D0, Read only */
> > -#define AD7280A_AUX_ADC_5_REG			0xA  /* D11 to D0, Read only */
> >  #define AD7280A_AUX_ADC_6_REG			0xB  /* D11 to D0, Read only */
> > -#define AD7280A_SELF_TEST_REG			0xC  /* D11 to D0, Read only */
> > =20
> >  #define AD7280A_CTRL_HB_REG			0xD  /* D15 to D8, Read/write */
> >  #define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
> >  #define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
> > -#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5		1
> > -#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
> > -#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
> >  #define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
> >  #define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
> > -#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5		1
> > -#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL			2
> >  #define     AD7280A_CTRL_HB_CONV_RREAD_NO		        3
> >  #define   AD7280A_CTRL_HB_CONV_START_MSK		BIT(3)
> > -#define     AD7280A_CTRL_HB_CONV_START_CNVST			0
> >  #define     AD7280A_CTRL_HB_CONV_START_CS			1
> >  #define   AD7280A_CTRL_HB_CONV_AVG_MSK			GENMASK(2, 1)
> > -#define     AD7280A_CTRL_HB_CONV_AVG_DIS			0
> > -#define     AD7280A_CTRL_HB_CONV_AVG_2				1
> > -#define     AD7280A_CTRL_HB_CONV_AVG_4			        2
> > -#define     AD7280A_CTRL_HB_CONV_AVG_8			        3
> >  #define   AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
> > =20
> >  #define AD7280A_CTRL_LB_REG			0xE  /* D7 to D0, Read/write */
> > @@ -71,7 +52,6 @@
> >  #define   AD7280A_CTRL_LB_MUST_SET			BIT(4)
> >  #define   AD7280A_CTRL_LB_THERMISTOR_MSK		BIT(3)
> >  #define   AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK		BIT(2)
> > -#define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK		BIT(1)
> >  #define   AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK		BIT(0)
> > =20
> >  #define AD7280A_CELL_OVERVOLTAGE_REG		0xF  /* D7 to D0, Read/write */
> > @@ -81,8 +61,6 @@
> > =20
> >  #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
> >  #define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> > -#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> > -#define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)
> >  #define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
> >  #define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> >  #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
> > @@ -92,15 +70,8 @@
> >  #define  AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK		GENMASK(7, 2)
> >  #define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
> >  #define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
> > -#define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
> > -#define AD7280A_CB3_TIMER_REG			0x17 /* D7 to D0, Read/write */
> > -#define AD7280A_CB4_TIMER_REG			0x18 /* D7 to D0, Read/write */
> > -#define AD7280A_CB5_TIMER_REG			0x19 /* D7 to D0, Read/write */
> > -#define AD7280A_CB6_TIMER_REG			0x1A /* D7 to D0, Read/write */
> > -#define AD7280A_PD_TIMER_REG			0x1B /* D7 to D0, Read/write */
> >  #define AD7280A_READ_REG			0x1C /* D7 to D0, Read/write */
> >  #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
> > -#define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
> > =20
> >  /* Transfer fields */
> >  #define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> > @@ -116,8 +87,6 @@
> >  #define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
> >  #define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
> >  #define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> > -#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> > -#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
> > =20
> >  /* Magic value used to indicate this special case */
> >  #define AD7280A_ALL_CELLS				(0xAD << 16)
> > @@ -135,7 +104,6 @@
> >  					     (c) - AD7280A_CELLS_PER_DEV)
> > =20
> >  #define AD7280A_DEVADDR_MASTER		0
> > -#define AD7280A_DEVADDR_ALL		0x1F
> > =20
> >  static const unsigned short ad7280a_n_avg[4] =3D {1, 2, 4, 8};
> >  static const unsigned short ad7280a_t_acq_ns[4] =3D {470, 1030, 1510, =
1945};
> > --=20
> > 2.43.0
> >  =20


