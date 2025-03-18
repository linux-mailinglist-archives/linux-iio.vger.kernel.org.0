Return-Path: <linux-iio+bounces-17014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0573A66DE9
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 09:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245DE1894FC7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D591F09A6;
	Tue, 18 Mar 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux+EoWXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E881C6FF4;
	Tue, 18 Mar 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285932; cv=none; b=Loo9bBvdz6yCGxjqvHyEkTqq/hx1Tiw/Y4rc43OIcKzZT9syYUKokSUDzYbfHFmkokQMIfdKqAezS3pT4qX2F7E7s6xVPkUb7Uy/bdb9PRV6prKy8LDE3+WEVnhNeXzLx3G7NDGcIn2B6kwv5KgY9QinOZ5egya8oaXRDJdxxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285932; c=relaxed/simple;
	bh=dScpwu90YUNJr/8QqjQTY3QTLtw075gaJ/d333YNViA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h+3RsmeX9lwXwSRX4DohRvpwTXcqlYr45yKL1RLETDxhrdAlQzcESTuFey/dxqKx6UX5Ci6VgRwU6FLTcSTa3GIDPzOgiKpFLCSq+Xg9OaAJgt4sB4ASYR5+MIC4ItKoc/PwwPugvrhvlPZYNDsUl8TC6/GeVRlzgT5LrXBR8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux+EoWXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DB4C4CEDD;
	Tue, 18 Mar 2025 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285931;
	bh=dScpwu90YUNJr/8QqjQTY3QTLtw075gaJ/d333YNViA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ux+EoWXcsfi0Ov90Qtlw0Ik/ZuG51uVPuZ4Mpz0Vb8owJ7L7Ni6SKWIQmAfAVHCUv
	 Vx+EsGw0fE5n3dT9gilGtaKr2L1kCT6H2YTxeMFv8egfbnHe+m0KxUiMIKxxB+GLyG
	 /4L73NONm4lyxBovfGF2DK8SCynJwIbCPaPowGgU0RbTFKh4g3Ey8iBGDO6fQ4UbdH
	 TmoI+3fUBQuqX+CTpJEuNxLTg9xsfh6k7rjMJyFPIa8NgZj02ssimy5QQ5qza5ZB00
	 FBHOf7dDP3CHZzV5tElqKiNZ+eSjAA+62JNxamL+fezQwaUytUmCd0RPyQyuqG5Bh/
	 5QRo1FJcQ+G2Q==
Date: Tue, 18 Mar 2025 01:18:47 -0700
From: Kees Cook <kees@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D=5Bnext=5D_iio=3A_cros=5Fec=3A_Avoid_?=
 =?US-ASCII?Q?-Wflex-array-member-not-at-end_warning?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z9jRtoDZM0opi_4C@google.com>
References: <Z9dy43vUUh4goi-Q@kspp> <Z9d7rp-ullvmXKoM@google.com> <112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com> <20250317120447.4fa26083@jic23-huawei> <Z9jRtoDZM0opi_4C@google.com>
Message-ID: <5524C796-6426-4A32-962E-AB4B4E3DC4A7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 17, 2025 6:51:50 PM PDT, Tzung-Bi Shih <tzungbi@kernel=2Eorg> wro=
te:
>On Mon, Mar 17, 2025 at 12:04:47PM +0000, Jonathan Cameron wrote:
>> On Mon, 17 Mar 2025 15:10:38 +1030
>> "Gustavo A=2E R=2E Silva" <gustavo@embeddedor=2Ecom> wrote:
>>=20
>> > On 17/03/25 12:02, Tzung-Bi Shih wrote:
>> > > On Mon, Mar 17, 2025 at 11:24:59AM +1030, Gustavo A=2E R=2E Silva w=
rote: =20
>> > >>   static int cros_ec_get_host_cmd_version_mask(struct cros_ec_devi=
ce *ec_dev,
>> > >>   					     u16 cmd_offset, u16 cmd, u32 *mask)
>> > >>   {
>> > >> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
>> > >> +			sizeof(struct ec_response_get_cmd_versions)); =20
>> > >=20
>> > > max(sizeof(struct ec_params_get_cmd_versions),
>> > >      sizeof(struct ec_response_get_cmd_versions))? =20
>> >=20
>> > I considered that, but DEFINE_RAW_FLEX() complains about it due to th=
e
>> >=20
>> > _Static_assert(__builtin_constant_p(count),				\
>> > 		       "onstack flex array members require compile-time const count=
");
>> >=20
>> Maybe add an assert that you indeed have the larger of the two + a comm=
ent
>> on why it matters?
>
>Or, is there a way for using compiler-time MAX()?  I failed to find so=2E

Did MAX() not work? I would expect it to do compile time comparison of two=
 sizeof()s=2E It can do other arithmetic no problem, e=2Eg=2E:
https://elixir=2Ebootlin=2Ecom/linux/v6=2E13=2E7/source/lib/vsprintf=2Ec#L=
1097

--=20
Kees Cook

