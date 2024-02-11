Return-Path: <linux-iio+bounces-2408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF17850A6F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 18:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB0E281728
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD115C602;
	Sun, 11 Feb 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWC/+LV7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263136113;
	Sun, 11 Feb 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671135; cv=none; b=QmuQpOndEuJURqhtTISOSmI30FqQmsNOBXBrR1WlpCF6oc27dTBKV1TtVLwVAsPwEkK3MAJD0+DxEFW6omlyUE5lP63jSLXAo34knwYkUfJzvKcy+T365DT3jOx7JjzVSGa1XV5aF6wfFZB1NM0X6AMfpoKr8V5DkCI9AUgK2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671135; c=relaxed/simple;
	bh=mNdbuRwrUz1jEcYxxSCl8gd9gECao5Hg1SbZQ8WSf1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHalrvg1TApEBqkVopQV1FYEdZvF/0qw8nilG1yRcgXKdmb4DL9cf1OxyOv0APzURWlD99xKBkCeccSMsydF2QDn0J93VatoTcQNx20CaEdp/6dh96jfWdG4DHBncYR1sskoKs/TElPQni9a5J6lIUoK7q9SigPjlA6Mr3uJdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWC/+LV7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3850ce741bso240770566b.3;
        Sun, 11 Feb 2024 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707671132; x=1708275932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqZoDCdN0It4QgX4CxbdL8p6BD8OnVCn+3+YWlkvwvc=;
        b=EWC/+LV74Ub0vv6HoZRhxU+8Z9CuJl94t1ibpKcoTT0sVlNILqteyFF9LZVi56rojx
         YllOEippOf7t7/RFMahA3vYTE5vyfAQXQplzkALtLVyO/HJa6YFSCxVYQGSGStv5iwMr
         N0Bl3L5CIRAJQ5NSvcfJ4aXr+44sPgp+H83WZvg0G0k21X/1oHZiIeWnzsnB+8fQIr/K
         5b4t50nH04yOCfhgiFCeM0GNnjfHlRLOBh60nrZTHqmT8ljsXOoVyQVY0PT1+EKCIn3Z
         Hl+giQDYj1w6mAf+ANBoCK3U0logZCmvUTOn4NnYZxSqN67hAvhltwEM9++WroFqE3V4
         2gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707671132; x=1708275932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqZoDCdN0It4QgX4CxbdL8p6BD8OnVCn+3+YWlkvwvc=;
        b=CQyjD8vALmwrkuVQ7CcmgrFix4BYMgZHVR+otRqNkNZLVrK9C2BBNq+5+94iCt7L7K
         +yjC6h8T75xv9IG6xrbAB9p0DHagFg5BAgMW2UizhSnte0dgmjYK29/4wD+Y6h7qHTB/
         KoyA30LnFFI60lExqKFKGGCxIZKyTiigtDgMDDWGVxl+piT0EJudsvePRN0ohs5D76oq
         32lYmffOt3KVo+IjUNVLrBocC0hwl2KWhm+R7OW46XAZ0QoqSJCbMHKitX8X14xii/E9
         Lv50B+ZQcNh8ycy8Mjha1twsOsjhbV4F9bZbd3K0Db9647BpvP8kmPkG0b0cT8bfNavX
         xnIQ==
X-Gm-Message-State: AOJu0Yyvh5ngAJ+G7CiAcXMtdYHNlQggNBFXy09PP1Gw7JLLVtcC5sZe
	44YuEPg7cTMcnvm281VPYFbWMNqr80gMD6EzSbUNZt2UalSvEgAHyZmcp/oKW66qGn2dfaRmEc9
	hrJwUliLqp9ti73OkDFLggqYqYf/CdTwHvmI=
X-Google-Smtp-Source: AGHT+IGaxmRVV6dIbYwLbAlh1oNjzfVXa/08mV4348nczrcJFeaQFTbgIniqYtxNaVuMvMmQjxP99zxvXgu376IK4SI=
X-Received: by 2002:a17:906:dc04:b0:a31:3f4f:bea7 with SMTP id
 yy4-20020a170906dc0400b00a313f4fbea7mr3041112ejb.39.1707671132534; Sun, 11
 Feb 2024 09:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5769241.DvuYhMxLoT@nobara-ally-pc> <20240210164956.3d29e3ee@jic23-huawei>
 <4923946.31r3eYUQgx@nobara-ally-pc> <12437546.O9o76ZdvQC@nobara-ally-pc>
In-Reply-To: <12437546.O9o76ZdvQC@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2024 19:04:56 +0200
Message-ID: <CAHp75Ve71Lb4PsGLGY5b_LNVn+Dk8z0Ags9rrWptSp8ot-UpRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading
To: Jonathan LoBue <jlobue10@gmail.com>, Hans De Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Platform Driver <platform-driver-x86@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, jagathjog1996@gmail.com, luke@ljones.dev, 
	benato.denis96@gmail.com, linux-iio@vger.kernel.org, lkml@antheas.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 12:32=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com=
> wrote:
>
> From 0aed4d398be185d43b92db63693bb1c5c6a8a78b Mon Sep 17 00:00:00 2001
> From: Jonathan LoBue <jlobue10@gmail.com>
> Date: Sat, 10 Feb 2024 12:28:35 -0800
> Subject: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading

Something went wrong, please use `git send-email ...` to send patches.

> This portion of the patch series aborts the loading of the bmc150 driver
> upon DMI board match for ASUS ROG ALLY and Ayaneo Air Plus (requested by
> ChimeraOS dev).

...

> +       if (dmi_match(DMI_BOARD_NAME, "RC71L") || (dmi_match(DMI_BOARD_NA=
ME, "AB05-AMD") && dmi_match(DMI_PRODUCT_NAME, "AIR Plus")))
> +               return -ENODEV; // Abort loading bmc150 for ASUS ROG ALLY=
, Ayaneo Air Plus

Please, make this as the proper table (see many examples in
drivers/platform/x86/ folder on how to do that).

...

Speaking of the PDx86 subsystem, OTOH maybe we want the quirk patch to
be outside of IIO and enumerate the IIO drivers based on i2c/spi ID
tables (there are also examples unde PDx86 folder for such tricks).

Hans, Ilpo, what do you think? (Jonathan, please also include Hans in
the similar cases in the future with ACPI IDs and related ambiguity.)


--=20
With Best Regards,
Andy Shevchenko

