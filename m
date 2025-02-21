Return-Path: <linux-iio+bounces-15913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F608A3FA08
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C75B8678C7
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CB1FBEB0;
	Fri, 21 Feb 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC+y0mkW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A41E7C38
	for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153253; cv=none; b=NSWuWdqVZNLeZvsMJ3FQwyAgrVBaeh60J2s+nV8wx2JzoLajaLoJufTMeLlCMySYPE9WOUz7bU76OWkDV+nKpFevAa+jMgZOpjBlo0uYZtsxO13d5bFzMCiPdE4N4k2DJot/4qWJCzccBXpoTsXOftGAkiFyx6OmOsmwN3y7T8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153253; c=relaxed/simple;
	bh=1W7rC/ZP8SbUKGe30TkGK1L/Cpk8gS7VpdsBLYjCytQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YIeurm8FBfG/AbDJoHCeZqEh0TY/FqzMnSo23zsrKEyHRQNbnagylX7mi7G7gLMsNR2aek6uOHsaTN0ZnRbXT0rs75O7UfEWJFmeYW13fWGV9pRueSzAZxshMRnpRTJ+nxbMS3shAUO1GW+kTdJ/8LNfAyDjZZ1VFZ61ldTa550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC+y0mkW; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f74b78df93so21852397b3.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153251; x=1740758051; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1W7rC/ZP8SbUKGe30TkGK1L/Cpk8gS7VpdsBLYjCytQ=;
        b=ZC+y0mkWn6/PuVBONyGofmY1D+UWer2Arfn8/Lf7mTOBHNGwdmky2Q8FQIL3+YDvvS
         7vvCwbQW7Z29WEyVMV/Y+xXVgoGg0JA6321k2n5QuF83DPn0k5B2xW+86FySbo5Ss3KN
         H4QMTNWXa9m3V5rPiPKdTAebXqhDmL3BPTggjh2zjsJl7az1ZEEbqd1L1itVGuYsCb4F
         bi06v7HQq1ZqCA7VQm+ORf9f7l52SuRk9tBF3ZtlJ9Wg4+/xm5Mh400O4q0QSoOg1MA3
         SgAyRfTOtspDEFB2mUXYcPPL2NR2a/of7huVESG1YGEfy4L1SmVr8o3fqSg+4JhYUBWx
         Hnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153251; x=1740758051;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1W7rC/ZP8SbUKGe30TkGK1L/Cpk8gS7VpdsBLYjCytQ=;
        b=Gewdmr2jriN2cUU02jWskUxBKnn2Xb5kqdRRUxLbz1cP3ASmzk7GIOa+PuQmGH3mWz
         JgYskNTrfJHqP0esse+kBTPTP2T7PuJgOls+bmU6UOY5NxM16gdqqTM3dOKi4Gef+7aY
         SCkKws1aVavKwEmp8bN5jlfOP33AQNHzUOLATySesTOnxBtfH+Y7UNcJnvW+c333nrpd
         FZDBDuY4PJ7rgoUs6R2MlybgGAbgzvSPiItQlLXotHp06EjMPQ/0JjhGoHUsvJQIwU67
         AQEE/EyV3AjT6YTVM6cBIRdExbg4/LXt9n5sMgq/ra5ECiu28XV10ivq+NBQ7Zb52jbw
         APSQ==
X-Gm-Message-State: AOJu0Yw9odFX8P/dfH3hDrBb0Hbc5h3DGs5SE6bvM6NZuvh1BR4CSaLi
	s2EE4glXNleCSYrDDF2em1vGKMHzk8wXnheLyaqblk3+JXX3LlZa+k5knx1JowVfPXLJI4mxcQ9
	+wRUHooiA45XHSRcRpi32ml+lDXJVqyDleCY=
X-Gm-Gg: ASbGnctqt5uYTsadUx4EH+5uDDbINntc4NxR/60UeSy66uMhXLMv9A/4eJ2z66MjubA
	80fUEAems5m4s8hm+1raklJg1NT3bawdLsctv9NfEPEQX9kjr0UPIqPZAC9csSBy+Sp/NbxFw4P
	8Sn4GNGeUt
X-Google-Smtp-Source: AGHT+IFziKSml93CIVvE2Kzgnp3oT05ztQHJptT+YQAlxTAdthpWu3s7qFdUPf+XfjzDcjUeydbyQ8S5Yk6X+JuiFnc=
X-Received: by 2002:a05:690c:7488:b0:6f9:938a:57af with SMTP id
 00721157ae682-6fbcc25bfd4mr34006487b3.17.1740153251152; Fri, 21 Feb 2025
 07:54:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Menon <simeddon@gmail.com>
Date: Fri, 21 Feb 2025 21:23:35 +0530
X-Gm-Features: AWEUYZn8ptd2Rn2CRaF6sA29e7E02IfEnkVw_vKSapwlIj4KMy7ckljXZOoqohM
Message-ID: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
Subject: GSoC IIO project: Siddharth Menon
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subject: Permission to work on dt bindings for staging drivers

I am interested in applying for GSoC under the IIO driver project.

I have a couple of patches that have been merged into the kernel,
and am now exploring DT bindings.

Currently, I am working on Coding Task 1 (sending cleanup patches).
While running checkpatch.pl, I noticed warnings about undocumented
DT-compatible strings.
Would creating the appropriate binding count as a cleanup patch or were
they left undocumented intentionally because they are staging drivers?

Regards,
Siddharth Menon

