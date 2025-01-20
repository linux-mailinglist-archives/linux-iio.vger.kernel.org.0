Return-Path: <linux-iio+bounces-14506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6450A170C7
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 17:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8A316B2A2
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9391EBA05;
	Mon, 20 Jan 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZs7W9CS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212791B87DB;
	Mon, 20 Jan 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391855; cv=none; b=VLBpzig9s1JEsj3s2vr4mD3WoN5+IGPK+lpqUQgrCrtIpIrYEo452CcLE2t+jXDL1JI9xeDAhllMTGmcY4P5yN238rPGrEPuX0RTGKjFZldvYGkJAZRLmz1wmmXHO1j3mm30G4e/+Pkp9kEjQgMFApxUlVyAaulTx/uX+8MpZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391855; c=relaxed/simple;
	bh=nc7r+OvWo0YLpyaM9ScWI+seOxtef8r6kSxub2Nb9Fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJSGuympKYX5IrcyCnwM/9H5Y7Cj38CV86wUam/bZVHLdP1iZNj8HwNqEs1r/o6lc2mWyagwZ6nDrlL4ku+jTUE2wUxdC3/PYuuoAHv7Hi4Kp0YZRNxlHYWDalQ7Ely4QZ2vAdgaPeJ+8APUFmrm3FFxN5IZfH3nxRWf+oMHOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZs7W9CS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so4149364f8f.0;
        Mon, 20 Jan 2025 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737391852; x=1737996652; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MSJltHSCUyCk1CTnQXce5HZJbPwqJZj13IAEyi20p/0=;
        b=UZs7W9CSLAOapMrwxE2pUt2gc2qxN6fnxEzXugyVDQxxpuB7wx5qsQeiA9V9gcqWie
         Z1qkTc8rtxmXirZql34eerWBeHJjvbatwkiQUYgwkeEgKfjWO9OsdLrE1HkN4enAXsWK
         1MbIkhXO1AD788XT+f0nCDGC34reJ5HblpR3Ln/xFtakEN42nk/0Us/3RYWtAwPzTwKn
         LdTYcFFsh1+Tfl2+mCA+8izs6GVaPHR3dWa3rZWkeeS7Zm0riAATa7WmeGW6HI8j/27C
         kc2OobPQ7k44vLDF8CIN4RuCQIgLr4Sp3BNg8XqQbWtN4r0CfHLYKCoenvZ58dzx/7W3
         HjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737391852; x=1737996652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSJltHSCUyCk1CTnQXce5HZJbPwqJZj13IAEyi20p/0=;
        b=VpL+jwooEE5SY8f/vwU+4n9PV7+LJMODkBEBGgblnueGnBrBdxTXq1uOHULAUdtM1a
         BM672EUDsYTCmJv6FzHbiQES9INZ6BB1AAkY5nfSvDEZDjTcqF4yaKuiaB7EyyVH+hvr
         K2E72eF1Vs6osMaT+vwq+YlK086r+fUaJrMHOfvr5elmubOcfg2+G5wYTkro3zch8HD7
         A0XDjnBUHBWqUcVpyqly0xzVFh5FWmrcdGe6XVDDNyVMZjRBWfVK3Z//tjCPGlNc+lmZ
         /UGHDNi4IhCzOkPyt9uvPKVoZ6FYO/939mwNzORay/T2nDocRFnzJ34Vx+daj1DGvmdY
         7VHA==
X-Forwarded-Encrypted: i=1; AJvYcCVZo8FtInEMM3NBGdtA0u2iKH/rYp0R1RlMtU0rQMPDprzpzYhKLfe6x8M0cA8krdlyeIJ0yj/RzeyevVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6B6yv/eJIJ0tLw5SciRonV9VwZGDiAVxr7G6X9ZSbZJkXefC
	8layspZovVtG5qe+2/amMDSxvHDc3JJp0yziaTtmnqT1CDtcek/j
X-Gm-Gg: ASbGncsO8La8J9Y2WoldE2s/fpCkCUQN40kCXIf4Sd6XaSBTqgARfFSm3/vf7kKCHjY
	C0nevvcax21SKWOWPVe8z9aGviNNVgpx+YaZcDOkeTDta6yYbfAAXkbhY8O8Zll0/n71FxbMsW7
	JREeSwvLMRw2VadUE3fOW0lsDoCOKUQom9rb8gOUnfKhWnDQ+X8DMfcdz2w9Fz4yFSe5n4UJ0S4
	yUkQnxvsj8BW3j+k9GDuaPMTX/Vr6rDSTuySQt8SzQcERIfONob06kHPfOrrgxGup3pj5unUyhF
	vS6Zca1R8YXzFWOirGEJ8GqALcpqRTWY0h365Jd9aw==
X-Google-Smtp-Source: AGHT+IFJIDmu4zgc0JBMA4+O9vCJ4Wujh9QONbM85jXKxMvDHllrHvVvUnXW4/xcI0MbGHvFB3xDmw==
X-Received: by 2002:a5d:5989:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38bf566f72cmr12710594f8f.24.1737391852087;
        Mon, 20 Jan 2025 08:50:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322236csm11082851f8f.39.2025.01.20.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:50:51 -0800 (PST)
Message-ID: <90dda46c3858a7bfa512d3f63d1bd1613bb2dfed.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] iio: introduce the FAULT event type
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 Jan 2025 16:50:52 +0000
In-Reply-To: <20250120-ad4111_openwire-v4-1-e647835dbe62@baylibre.com>
References: <20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com>
	 <20250120-ad4111_openwire-v4-1-e647835dbe62@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 15:10 +0100, Guillaume Ranquet wrote:
> Add a new event type to describe an hardware failure.
>=20
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-event.c | 2 ++
> =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0 | 2 ++
> =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0 | 4 ++++
> =C2=A03 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-
> event.c
> index
> db06501b0e61a91e3b06345b418504803f4aefb5..06295cfc2da8b1df17061cf58ade38d=
88020
> 359e 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -232,6 +232,7 @@ static const char * const iio_ev_type_text[] =3D {
> =C2=A0	[IIO_EV_TYPE_CHANGE] =3D "change",
> =C2=A0	[IIO_EV_TYPE_MAG_REFERENCED] =3D "mag_referenced",
> =C2=A0	[IIO_EV_TYPE_GESTURE] =3D "gesture",
> +	[IIO_EV_TYPE_FAULT] =3D "fault",
> =C2=A0};
> =C2=A0
> =C2=A0static const char * const iio_ev_dir_text[] =3D {
> @@ -240,6 +241,7 @@ static const char * const iio_ev_dir_text[] =3D {
> =C2=A0	[IIO_EV_DIR_FALLING] =3D "falling",
> =C2=A0	[IIO_EV_DIR_SINGLETAP] =3D "singletap",
> =C2=A0	[IIO_EV_DIR_DOUBLETAP] =3D "doubletap",
> +	[IIO_EV_DIR_FAULT_OPENWIRE] =3D "openwire",
> =C2=A0};
> =C2=A0
> =C2=A0static const char * const iio_ev_info_text[] =3D {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/type=
s.h
> index
> 12886d4465e4896aedce837c2df63c78f83a5496..3eb0821af7a40e29544fbcc67c48e08=
5507e
> 13d0 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -119,6 +119,7 @@ enum iio_event_type {
> =C2=A0	IIO_EV_TYPE_CHANGE,
> =C2=A0	IIO_EV_TYPE_MAG_REFERENCED,
> =C2=A0	IIO_EV_TYPE_GESTURE,
> +	IIO_EV_TYPE_FAULT,
> =C2=A0};
> =C2=A0
> =C2=A0enum iio_event_direction {
> @@ -128,6 +129,7 @@ enum iio_event_direction {
> =C2=A0	IIO_EV_DIR_NONE,
> =C2=A0	IIO_EV_DIR_SINGLETAP,
> =C2=A0	IIO_EV_DIR_DOUBLETAP,
> +	IIO_EV_DIR_FAULT_OPENWIRE,
> =C2=A0};
> =C2=A0
> =C2=A0#endif /* _UAPI_IIO_TYPES_H_ */
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.=
c
> index
> cccf62ea2b8f9b55a83a4960c1a60087c7b053f3..eab7b082f19db8703aca55af7dbf4f1=
d624a
> a3af 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -75,6 +75,7 @@ static const char * const iio_ev_type_text[] =3D {
> =C2=A0	[IIO_EV_TYPE_CHANGE] =3D "change",
> =C2=A0	[IIO_EV_TYPE_MAG_REFERENCED] =3D "mag_referenced",
> =C2=A0	[IIO_EV_TYPE_GESTURE] =3D "gesture",
> +	[IIO_EV_TYPE_FAULT] =3D "fault",
> =C2=A0};
> =C2=A0
> =C2=A0static const char * const iio_ev_dir_text[] =3D {
> @@ -83,6 +84,7 @@ static const char * const iio_ev_dir_text[] =3D {
> =C2=A0	[IIO_EV_DIR_FALLING] =3D "falling",
> =C2=A0	[IIO_EV_DIR_SINGLETAP] =3D "singletap",
> =C2=A0	[IIO_EV_DIR_DOUBLETAP] =3D "doubletap",
> +	[IIO_EV_DIR_FAULT_OPENWIRE] =3D "openwire",
> =C2=A0};
> =C2=A0
> =C2=A0static const char * const iio_modifier_names[] =3D {
> @@ -249,6 +251,7 @@ static bool event_is_known(struct iio_event_data *eve=
nt)
> =C2=A0	case IIO_EV_TYPE_MAG_ADAPTIVE:
> =C2=A0	case IIO_EV_TYPE_CHANGE:
> =C2=A0	case IIO_EV_TYPE_GESTURE:
> +	case IIO_EV_TYPE_FAULT:
> =C2=A0		break;
> =C2=A0	default:
> =C2=A0		return false;
> @@ -260,6 +263,7 @@ static bool event_is_known(struct iio_event_data *eve=
nt)
> =C2=A0	case IIO_EV_DIR_FALLING:
> =C2=A0	case IIO_EV_DIR_SINGLETAP:
> =C2=A0	case IIO_EV_DIR_DOUBLETAP:
> +	case IIO_EV_DIR_FAULT_OPENWIRE:
> =C2=A0	case IIO_EV_DIR_NONE:
> =C2=A0		break;
> =C2=A0	default:
>=20


