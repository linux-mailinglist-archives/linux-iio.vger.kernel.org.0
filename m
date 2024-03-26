Return-Path: <linux-iio+bounces-3808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849088BD0A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 10:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17081F3C605
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B645C18;
	Tue, 26 Mar 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZQAP6Bev"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9E3F9ED;
	Tue, 26 Mar 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443628; cv=none; b=XMMqAAeCAGwrRO3iQlYyfYbxe6Xj11/TiiHvsAuxoUsWDO9hbxfqze+BzXZ2c7qu32TiNf+v2KT2G0lF+6+TPsLuutgekZWrsdiU0aD49UrDNausvyOldLDmDphd+8zblktfvWGhDaElEAcaqcfAA6mMGsfhJB8ypwQVkcKqIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443628; c=relaxed/simple;
	bh=3Tt1EQy9QY5+yDcNnE7KBJQv3Ctt4dPYPHyySoY5K/I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tk4pIU7pSnl1hFTb1vbckI+BIqB8fmbZgW7RItlqVMVXb9TAj6QsudO4z9V8nR/m6N4MOayoCnwGOSZwGruwl4LrLC7RSjSaq9W6Yng9FD2abmiOASD/3jrGvQTIAt1Ho7AiKMcGzNZy8e2pYs2zYQxQ9iohS6QN6OA50Zbwl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZQAP6Bev; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/djGL67+NWnDPrRkxvM0aNHvT6Zkhfa6nfqpOBGeR24=;
	b=ZQAP6Bev1yFZGV2AwattLpzK2wPyLfqoq+y8JfWprenE+s1ZPdXI/HTAOqnTku7ATM8ohBDYTmm
	9x5JylHhVzP/q5QwThubQxd8YqQLqhx8/32X/uoxyd9HaqMauNoOD2fzXDNyNpP2HK1DiOGdnVxFS
	mAzWqN4cpioxTgcytwZUgc01VQt6njjVf3C1pSeJK4J5oq/jK5+mnLKEtoJSeDHHCqOgLPqNmxhwP
	OVHTm5OSk2arh3hV94z2ttrkxlxz5VCYjDFWRF8CB8683IUuRoG2xtIThfDPLqyTzytl7IUmrmGYU
	1y7y1/pJGKtRhHtrenE8n25bLvn06ypdJltQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rp2fM-0009TD-IP; Tue, 26 Mar 2024 10:00:20 +0100
Received: from [185.17.218.86] (helo=smtpclient.apple)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1rp2fL-000DcW-2w;
	Tue, 26 Mar 2024 10:00:19 +0100
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 2/5] iio: dac: ti-dac5571: Add DAC081C081 support
From: Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <20240325203245.31660-3-laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Mar 2024 10:00:09 +0100
Cc: devicetree@vger.kernel.org,
 imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Trevor Zaharichuk <trevor@au-zone.com>,
 Greg Lytle <greg@au-zone.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0261441D-46A9-4513-B598-B1204FD86B30@geanix.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
 <20240325203245.31660-3-laurent.pinchart@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27225/Mon Mar 25 09:30:27 2024)



> On 25 Mar 2024, at 21.32, Laurent Pinchart =
<laurent.pinchart@ideasonboard.com> wrote:
>=20
> The DAC081C081 is a TI DAC whose software interface is compatible with
> the DAC5571. It is the 8-bit version of the DAC121C081, already
> supported by the DAC5571 driver. Extends the driver to support this
> chip.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com <mailto:sean@geanix.com>>
> ---
> drivers/iio/dac/ti-dac5571.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ti-dac5571.c =
b/drivers/iio/dac/ti-dac5571.c
> index efb1269a77c1..c5162b72951a 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -13,6 +13,7 @@
>  * https://www.ti.com/lit/ds/symlink/dac5573.pdf
>  * https://www.ti.com/lit/ds/symlink/dac6573.pdf
>  * https://www.ti.com/lit/ds/symlink/dac7573.pdf
> + * https://www.ti.com/lit/ds/symlink/dac081c081.pdf
>  * https://www.ti.com/lit/ds/symlink/dac121c081.pdf
>  */
>=20
> @@ -386,6 +387,7 @@ static void dac5571_remove(struct i2c_client *i2c)
> }
>=20
> static const struct of_device_id dac5571_of_id[] =3D {
> + {.compatible =3D "ti,dac081c081", .data =3D =
&dac5571_spec[single_8bit] },
> {.compatible =3D "ti,dac121c081", .data =3D =
&dac5571_spec[single_12bit] },
> {.compatible =3D "ti,dac5571", .data =3D &dac5571_spec[single_8bit] },
> {.compatible =3D "ti,dac6571", .data =3D &dac5571_spec[single_10bit] =
},
> @@ -401,6 +403,7 @@ static const struct of_device_id dac5571_of_id[] =3D=
 {
> MODULE_DEVICE_TABLE(of, dac5571_of_id);
>=20
> static const struct i2c_device_id dac5571_id[] =3D {
> + {"dac081c081", (kernel_ulong_t)&dac5571_spec[single_8bit] },
> {"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
> {"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
> {"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20



