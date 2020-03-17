Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50641884C1
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgCQNIL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 09:08:11 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56684 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgCQNIL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 09:08:11 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 73D9440213;
        Tue, 17 Mar 2020 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584450490; bh=yojPkfV+TFRQrxmUkxvuumDuTpYDeZum3PKcNzcAMNU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=l6vRYmRiYfjwy75tYEQhor8w+2cM5jGF8DImr4sixrJxzWfrAt72Q6NNAzKdGz3P7
         HaWwdJeZ9ClOYehCHCYB/TZMcnoLp7dpU8ShDb9Ba6RntNewz0Ze6e57KTTCkB4ose
         I2RBOANPD5ktvM6M65xJhuLWZUuSyb79VvZhGRiQwT60Onp83pgZPwu7f+RTCZfbL9
         7PCKmqtoSsvnibLzs7AvWm9P/MRvd4CHzStyv14Xo/e3HBswZ9Fgq8VjEm4WL/qXp+
         gzkuftvpwRyhOOqP4xapccPdPwVVOBH3QGYTfGQ6h76KefQReQ6JUsTa8KvlAYsE4J
         /1O1gNpj0FvWw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 47914A006C;
        Tue, 17 Mar 2020 13:08:10 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Mar 2020 06:08:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 17 Mar 2020 06:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngnvAepbIE8/Lubl1exdhygqh7r1Ulsbb07zxhwqrZ3Ci8o1Piw2PvEilxpr5rd9a/p9HexKbXfV3CkS6AjKY53oA1zHBAhiNLeW8VBb6OHuRLJShygIiH5jvOY+bAKESYGAVx8MdFmaftwHK+ltGOgoCDVW7KOTy5x/+23rF+Saz1D0FBRfnRmIkwQhZKUapJ+SGr/cu1gBZBAdlq5cpGsFtT/bsBCzNjb+Jt0/BTq6IVMcWvqa3/JxQw/Lv6AKLb2WtL3y50ZurKds+7UHSmnYONg0hHpat85jscSIJW7Z68xpHpoiC4gng9kTslHbY0O8ygStaVwjzsBYtwIkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3nSXWi2Ja/RzAoMz319EOy4xhRpKho9eByKckmkqww=;
 b=MY5PrqE6UHjPlMVafA68RaqMmY1FAhDnlytvBNfjQQOxKl5k24tuyPhd3ychP0lPYTY+/f1NC8f9cxgst2L8GzOf3X/afPru3XjmvdEtxog7NpLCm5sp0WFwQfGakDiq/p5YDJL+DLmG+26EIWkWryh2o1Q/TPluOATxvjijMWoyOeCAmlFYj/ZUAW4B5d5K7pKnUgNReC/oqnt7d140Des8bbzwV5J0Ogebn2XjyJmSK5UUpNy6xXz1InGwFRtyq2gDHYnbBvt8b+RkHaHTjhp7SlNPmxENY+WxVzdad7eM9bFbcXU1icu2v7AHogEUtdOM3Zqk7HipWLifZeOQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3nSXWi2Ja/RzAoMz319EOy4xhRpKho9eByKckmkqww=;
 b=q3YQ4DX3PcSJBHlgNELIPY3jZQBtO4J3kE99BHqglC+Cn4LbZzee1TSL4/WtgyyACmL/dsA/17GRwB7mDC+ZzFUiHF8Zs5Qf9gGbKVZOcVNRTc/+qw8aqTYql6agu0G0eU29TiHeAWMVLC1M6UnKl+hlu28kcRkRTDra2LDo5bU=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3750.namprd12.prod.outlook.com (2603:10b6:610:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 13:08:08 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:08:08 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Subject: RE: [PATCH] iio: imu: st_lsm6dsx: flush hw FIFO before resetting the
 device
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: flush hw FIFO before resetting the
 device
Thread-Index: AQHV+WIrsWarvcg4MkuxuyIDDfWRaKhMxFTg
Date:   Tue, 17 Mar 2020 13:08:08 +0000
Message-ID: <CH2PR12MB4216CB1A1882DBE10CAAC967AEF60@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <e9beff6b3a32ddf0de20821e50cf3ed562e36b48.1584122527.git.lorenzo@kernel.org>
In-Reply-To: <e9beff6b3a32ddf0de20821e50cf3ed562e36b48.1584122527.git.lorenzo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=soares@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9af9087-bbaf-4676-0732-08d7ca743ced
x-ms-traffictypediagnostic: CH2PR12MB3750:
x-microsoft-antispam-prvs: <CH2PR12MB3750099F6F9A79D74522DD5EAEF60@CH2PR12MB3750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(52536014)(6506007)(5660300002)(71200400001)(86362001)(186003)(7696005)(8936002)(81156014)(76116006)(8676002)(33656002)(4326008)(81166006)(55016002)(9686003)(54906003)(110136005)(316002)(66556008)(66446008)(64756008)(66946007)(66476007)(478600001)(26005)(2906002)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3750;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIj2iYoBEGTsu0wCDVtW4eX6Z4foc0OcL7poMFSsg/PZXHLtQgTJrSjnYoBNRV1aZLr7FrK7h+DPuX9g4G5Z5EDB4yoH2eJSDczKWbZNx+NVyHJa1AWTNGQxcpqkYrTim/KAoQ/js2YJlz0Ws82CckWqCGGU0eC1ZsqzRf9vQLwWlG+XmcgilXDMNOcJMu6efW+sh2pEJE4BDcTTAzAGz9tvdxvidtzWnPtSpGBgRK+SHGZ1I9xf2HoJ0LMOWLuj77xkxzzYHIoWy62qou7XbzAuMsTlxi1lkXa3KRNy7ShXbNlDDkFfqb4rpLmsBzxYqvAWO7u3egOzHfG+5qUmKi9UngBewzCVs3poIshlLap876zLgZVGvATSD1AH9AROaa8B4cP2Nn+vrQvy3D7+6y0OBHZixQGYH9m8tQoKnnXEGY1/+KuJOH5keruMMcCpF9z4g8u6CmZ4rIT5blhi5WXj9kZ3HpAPhk58uZ9o/JLoLEkVGgXTzFfIePd+a6lVmARLtYIhiZ9/M/MBJpzzDw==
x-ms-exchange-antispam-messagedata: kWWtMldkOcf0ABiiDBXSAgq1YnerpVJi53z791bxehKHVIsyHE5jS5G+qY2Ig/WawOr0FAiFbAR6Fx6eTW1pABFxO3/b6CwFusgCD/qHzM+eIx9WiAVEkmtWfrC1RYvOvri3qD6Hxqy3PHhSnv+3xA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9af9087-bbaf-4676-0732-08d7ca743ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 13:08:08.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEue2RrzK1fkCUwEBpXAY+Z2H1DGVqKELCBB8KCkwBgfaUHaK7WniBNI73xBIykMbAk4OD3HtbAoSqohi7evyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lorenzo,

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, Mar 13, 2020 at 18:06:00

> flush hw FIFO before device reset in order to avoid possible races
> on interrupt line 1. If the first interrupt line is asserted during
> hw reset the device will work in I3C-only mode (if it is supported)
>=20
> Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
> Fixes: 43901008fde0 ("iio: imu: st_lsm6dsx: add support to LSM6DSR")
> Reported-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> This is a new version of: "iio: imu: st_lsm6dsx: disable I3C support duri=
ng
> device reset"
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.kernel.o=
rg_patch_11425389_&d=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9x77Y0K=
d0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3Dd7oUzE4fWeY3JqYqqd-uW_v1SJkij_sOpXRvpm3-T=
hg&s=3DBEgROrIZoG9oGrwQEENFz0DP88VioXUhpeZP2Y168XI&e=3D=20
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 +++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 84d219ae6aee..4426524b59f2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2036,11 +2036,21 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm=
6dsx_hw *hw)
>  	return 0;
>  }
> =20
> -static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> +static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
>  {
>  	const struct st_lsm6dsx_reg *reg;
>  	int err;
> =20
> +	/*
> +	 * flush hw FIFO before device reset in order to avoid
> +	 * possible races on interrupt line 1. If the first interrupt
> +	 * line is asserted during hw reset the device will work in
> +	 * I3C-only mode (if it is supported)
> +	 */
> +	err =3D st_lsm6dsx_flush_fifo(hw);
> +	if (err < 0 && err !=3D -ENOTSUPP)
> +		return err;
> +
>  	/* device sw reset */
>  	reg =3D &hw->settings->reset;
>  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> @@ -2059,6 +2069,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6ds=
x_hw *hw)
> =20
>  	msleep(50);
> =20
> +	return 0;
> +}
> +
> +static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> +{
> +	const struct st_lsm6dsx_reg *reg;
> +	int err;
> +
> +	err =3D st_lsm6dsx_reset_device(hw);
> +	if (err < 0)
> +		return err;
> +
>  	/* enable Block Data Update */
>  	reg =3D &hw->settings->bdu;
>  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> --=20
> 2.24.1

I tested the patch and the I3C interface is working fine in this version.

Reviewed-by: Vitor Soares <vitor.soares@synopsys.com>
Tested-by: Vitor Soares <vitor.soares@synopsys.com>

Best regards,
Vitor=20
Soares


