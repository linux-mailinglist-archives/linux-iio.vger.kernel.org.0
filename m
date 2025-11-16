Return-Path: <linux-iio+bounces-26255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E852C61317
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 12:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF53F4E4441
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F12882BE;
	Sun, 16 Nov 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8SKi9Ef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437F221710
	for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763291327; cv=none; b=FspoRwiioZGrJfWX319LV5XvLkedNRtMK6VZMB1Er2UMeQwhMlW//z/J/wm/nyPQlEDzO/LJZ0n8dcle+A9OOZii13/ZJ445ITI7UDFP8z3oz5288YgTLzHEl1WrKnTe6DoE1U9MtA1Sxv0B0CPif4KARqOM+7AG9UTU+FAt7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763291327; c=relaxed/simple;
	bh=++IoyEjM7KOb8pLDO21vO4riCGkzG+6WhUjjBZc7xOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPyoU5+gV+YFGOOmmN25TThRMaZscdQfky9JwE5tuXiUqYvN6hAK3ME7edRii325AU6TlTgH9pjxhNTEcXNEo21UQOqJ/xqCCRQaYap+hfUk8HrSNhh3Br1wB6lj1TKUWspfimg8Y4xImQQJPfR5h0JK53/aYzxGbJ7PysJ5k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8SKi9Ef; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b737c6c13e1so190851966b.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763291324; x=1763896124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++IoyEjM7KOb8pLDO21vO4riCGkzG+6WhUjjBZc7xOg=;
        b=Z8SKi9EfMfyaDMMMcQjiS/GhRx5SfT73IKRtjTT+FlGCu8Yvm53t4Qs/4CCl7rjRcM
         AG9AWRpNz2O/6CAoZ8G2wHcy7Sx/VlYHeXeXi/DaN2DPaCwBLZs2XE5Kvdx1ki4gcNjS
         FUgrf/51uzDYJZLIZFnhd2LvwsFEryC5im3VcgplZyIus49CGe/1nFRNrVSpcOcqIfND
         xCp+Ty5hp5Ha0Xbqo2vapoAMESnndIEFQkA0E3KVAhI/P+IRnGR+I8IgnWNjjzpUdRLh
         GYc0h8vNPShn8DJF4U9SZJr6AkAqi23nV/X5hZMoKNAzbcfdHgPomxEPYkaxwIwjrSMV
         Tggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763291324; x=1763896124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++IoyEjM7KOb8pLDO21vO4riCGkzG+6WhUjjBZc7xOg=;
        b=CYPlT6pf3iVyEKA7QwoUMdX1hR9q7OsjMQKpDzfMS0SNvZ11Fa28fWG1LDL7uFmAUg
         FvJyPZXKwu4ITtiJxRdcacSh9uLcQgkV4tAiSCp2amrfoETbZnxt5AtW7UmNQq9IEN66
         WW0CuGDsH6zQ5y1RSmCwTJqvBJK3NbGkfpG1OPHOtwgChdYZmHTfvRPsHbDbH5mqiHf4
         IF+FpBlb2Z+cDZJr5nDKUdpPnsDuXLoGYNUWvTGui/2Bhr2XEb75X6ezOVsJR096SmiH
         d9EHgEmr1U5RIYgqLx8sGc/jElfCk4esqC21zfcGw52Ht4MRuUpVXrwVBJw2zn/KJZEp
         Xc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnkRvKq2NMLIuI1f+mO5uhkH7el3RMSDyydHdyYd8Okbedt3iNRpiAOLO+taBNbQRaBjZbeJD5Ekg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykD7dAsmWWE7m4/f5ewMU+MsaM0/fJ0NVeGhMwSXDvibUefTXi
	2evPm4tgyGexytOZGNIxD6C0z4exbfZJWFUj3n+9KIjFOTK4q+12JIVIB9QGLD7u/XfJ6SQZAF3
	XiONqWrmll5H6rGBvBSzBRfcCLkEzrME=
X-Gm-Gg: ASbGnctx7g12PKk/Bk1zk1LJ5C5xzGhzUyGQ7RhfKWxr7uMtSR5nEKOYVVH/iAhpnjj
	uN9OWC923daFWBIQAZlqA7KxwOw2zJRRHHP+ALO8oVhApGYFmJhbhqb0j7rKMBYJ8ZLZ8pqieQl
	TpwUdk09wWuZGhjjWOCjj/OcIHe9lmex60b50B8elG2UoDISENL+enktDe57GZcFFpT3kgJVUkI
	L+EhwdyHS1Qd7Lhby4wwIZXw8ygDyN8hdHJQllSvjDmYoDU+hKjmTQE99ZgxV/eLOVq95Z9Y6f5
	tiJva8hqTIf/1IKXe5xoMHEy/YzreeyfghsezcN0xVQKI/HxyHSk3mbmfwGybuXDmMuRAg==
X-Google-Smtp-Source: AGHT+IHht8SUA63TQ9BgVyqZrHjzgfqHkR7ptlsmUxvSYczTcMjuN8RjFboIeyOG2OJHW+EKkQL5Jqfw814RibCwMm8=
X-Received: by 2002:a17:907:1c86:b0:b6d:5262:a615 with SMTP id
 a640c23a62f3a-b73679628b9mr1077586166b.41.1763291324117; Sun, 16 Nov 2025
 03:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
In-Reply-To: <20251116101620.25277-1-i.shihao.999@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 16 Nov 2025 13:08:07 +0200
X-Gm-Features: AWmQ_bmKKoTGDT6BVX8LV4jXNIna_cAeoRA_R9V_7gQFWqzB8w8aFos43v0XDws
Message-ID: <CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with sysfs_emit()
To: Shi Hao <i.shihao.999@gmail.com>
Cc: Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 12:16=E2=80=AFPM Shi Hao <i.shihao.999@gmail.com> w=
rote:
>
> Convert several sprintf() calls to sysfs_emit() in the
> sysfs show functions, as it is the preferred helper and
> prevents potential buffer overruns.
>
> No functional changes intended.

I briefly looked at it and see no issues,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

