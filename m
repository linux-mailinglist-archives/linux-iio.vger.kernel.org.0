Return-Path: <linux-iio+bounces-2589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDD856C4F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6DB1C2179A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA51384B4;
	Thu, 15 Feb 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7yh5zWK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA793138494
	for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021205; cv=none; b=jnqgGeL+bqgN3UPXPa9HWc/NpkDEXR5kWp/x6d0QD/WMJxjsyFFVaGmr18C0wrEmwUXwgvXGEqgcY5ee7Q+ikdlWf8OSnSXscXlmLICubfbqF4Xum21TJZsi5qLBgZDu85IFwgjT+0Hjes3rUMXXWkSmmI76F+vBs+/O4fjtw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021205; c=relaxed/simple;
	bh=dsjRJ4pxFfII3QCpIb3/y4Sj789iM54tpGvdA/RBKgI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eUpgqhemouYh5Mxs8652VBMRWKb1Ag9GXLKvsnuQvL88ywlVHxGvlXOrBombzvmR8TJV+hpD3R5kq3sR4pxD1sr/7C0e5z2hj39KI7E9aejdwfX85llksQYEBkuXnPqFBxmlKP++pXjwxHkwC1avwYwp84RPHf1ZBtpf41oF7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7yh5zWK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so728522a12.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708021203; x=1708626003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTqcMX1uaZ43t8ynpeNqmwO1jZ9qut1kYEJeV82SSCI=;
        b=i7yh5zWK3sU6e4dGeuUd08AqrKpQtDGsuKoRde/X/VmdGe3vL4/d+W3ib4pzuaqhEx
         KqExdJcPugj1COg6AUjmDV0t6cALz7oPL09AhaJRAHHE3y7eZ/Acopd146Rs7kZ/V8Fi
         6t/MDYs0eZq78IqnIheWPhZN5cyRk7KZu92ozENZ5JWRBtp/huuWu6wrZTdT1LHkLNy3
         hoJJYsIyOdNLSMZdkvCwr58KXxIpEOsFROfd8Y6NzDt7N+sNgLbK3dFH5I2ZhLZ2cS3/
         HxsSkJ4t5XW6/L/SUiPbYM7HjZVPrn0L2kjfhdv6E/lYULEObb6O/qQ/YivcI1j8oW4p
         +n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021203; x=1708626003;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTqcMX1uaZ43t8ynpeNqmwO1jZ9qut1kYEJeV82SSCI=;
        b=b2uHc8BMRUVSyGjKKOCZVpiM9i8hIWCTCV5amnX/pl54A+T0rgpow7BDVL1TQTyZFi
         3HgjDHh24OnlD58q/OUonld7PhStAYAoWvMWDZG8ic3Tayr98tLehgFG1yQJxcbe6KyZ
         wKZJ8q95MJxT/aLVln9d9iDl8e9hzNVV17Jr8N0bS+0aki2gkvOXtHy1NJ2RgQ6c8tLF
         fuucuh37x9JKKyYvTV13GVK8LncvM5IiwBPgFSejbC7lISg5SPPT1MtGmEW1W/l2KxFh
         d4shLKndnxloSkaIe8+x0OmfK2pSFSlya/jv5/+vLRM6upBaam6i49WWR05W5ET04+Ds
         uBGg==
X-Gm-Message-State: AOJu0YwsjUW2J5bTjXoJ5UPbU53KbovAaiyHmwh5Vbjo4mF+NiHCI0Qj
	lhDGIXdVLJR95AjuXOtr5DWNlshwdxsxI00fMCqy/5oVQs7+EGigHfDRIS8IcjbIAysCWiHcgGO
	EB8TU/MGufbZd6qjn/iLWyIiLdnc=
X-Google-Smtp-Source: AGHT+IEmeVUkMxHu1vmt9peaFXGVJTVPGl2GwKZ4rN0W3kFtUeOhRyB9l7U92ayCxzocecG+rLk8CEkY2rYGvs/t50A=
X-Received: by 2002:a17:90b:288e:b0:299:277a:b10a with SMTP id
 qc14-20020a17090b288e00b00299277ab10amr1052863pjb.49.1708021203085; Thu, 15
 Feb 2024 10:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: J Lo <jlobue10@gmail.com>
Date: Thu, 15 Feb 2024 10:19:52 -0800
Message-ID: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
Subject: [PATCH v5 0/2] Add bmi323 support for ASUS ROG ALLY
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	jagath jogj <jagathjog1996@gmail.com>, Luke Jones <luke@ljones.dev>, 
	Denis Benato <benato.denis96@gmail.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	Derek John Clark <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Jonathan LoBue <jlobue10@gmail.com>

Changes since v4:
- Fixed comment location in bmc150.
- Fixed signed off by portion.

Jonathan LoBue (2):
  iio: accel: bmc150: Duplicate ACPI entries
  iio: imu: bmi323: Add and enable ACPI Match Table

 drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)
--
2.43.0

