Return-Path: <linux-iio+bounces-17391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D618A75E6F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D01889777
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797915D5B6;
	Mon, 31 Mar 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiDj4lX7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C572157493
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743397208; cv=none; b=YGbS4507/RD7qbsw6ne+v9SQG2SiMcFkZd4mq8On+VZisouoC6KBhpOXpZxTOFQc4tGJyFkszx+f84RRFw8U86bCcsVh/IpXT88+7CeeszoyhOhd43fkuaKzpbtKJkogFxRj4kzeYkxUg2GkZxI8UpjlNjOi3pm3dMfVPgJ0BS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743397208; c=relaxed/simple;
	bh=0jHT5jexWfJNyzoT6u+knnOKbPPpZmLauP6ckqRKEEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VwxjOQHDfb5EYEVak6EnGujiqcQX65WD39cnX+ANXXPjJSaNpI5a4hZ9WPrEl8ntWIPzQbzCg7gHbcgj4iYAvUc8+F+r4tLX+VEbFy7TfFJE8yhFzdlQOTvnIUZSd8oIeXf61aJhtTd6td7M+pjk5Fu+1aCopyHT406HVSQ5Tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiDj4lX7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so4799391e87.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Mar 2025 22:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743397204; x=1744002004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Op8FfqLMp5o5mAdtLuy/WNGbSdko5o4LPcyp5/DqUK8=;
        b=LiDj4lX7vhidu6aq9SoPFo/4UoGULFwxwJTfuUa/skKy2vpxz1ACFRFHAEG3RKCgh+
         Ba4nklF+3nR+Z5/L1HCpnwIAJH5CHs4wZHVumjrTj3rp3YZGQSYPv5pjujK+3P2nsBIN
         80as+jQuzGBpZjqjk4h0tPVVRiLaoyqvivGUE+zu5d0hhG1tbo+CGkwlJEvW469Fhjsq
         ALZdY70Nc0Hw5s5aiaKADnJdk9mxUmpSqSO41qXBNA7Pd0Vk7DuLuKnByrQICpTZMK6z
         3UUzgJEGmNk6mdmaxMK2ybtQr4PbSY/RG8f/NOG/8k4xkVNZs5eqi51Z4t3pR3emWgg0
         nUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743397204; x=1744002004;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Op8FfqLMp5o5mAdtLuy/WNGbSdko5o4LPcyp5/DqUK8=;
        b=L9D4/MEl8hbY7qAD2D/kIrtlui5Rj05XsCsVbQ1D1soCT0eQfUHXt8VzbniBUqErMa
         Yny9YIF1czm2HEvG0XEQIp90CuFecYye6sK5LD8QLbISror5K08umVKhwbuvkl0dskeb
         9SAa82JpvRqbtfbWoCX2dibpLLPjjgy9NdBSJMGJvELT3TdAki/ZKeka8uvdCLdwWhm3
         8xe6LyCZrPw6wG1nOh7E49BJR6JhAxx3+KuS8iYJJyUlxhy7AP1/t5RyfhHZp7scl1c+
         9BRt72/mMrIRQYEw+9xX3SoY+gukVrboOKcfa1yVQReZaj1GIlao5hHNSfrX/t2xiMLP
         mGUg==
X-Gm-Message-State: AOJu0YyPBeUgs8RIQRWJpF2XvytJQ6WAT+PtChEyP3J6Gm89yaKduwT0
	+LasMJu/0KZoIqb1mLvVdHzjTU0xNSg9OtoklkmCPUaGcHf5q9DHYl5NrxEdbWwY5LxWeWYnC8G
	jqaWF9J6z1DYdkNEuzx3wG2UVpi1ta8m1
X-Gm-Gg: ASbGnctq808EOnZER2Z4mxuY+wBrHMsChM60VxaLBtHp/T3n2OvulX6cFP++uv8BfzT
	PKmv+iA/O2yIzFOh/p+3bDUYuIcFWbqOVmiF1vTnuRB3wQzmd6CsBhxT1SCa1FNkZjL613TBZxE
	+005p/7X2Cr94OG5YUMnPy+MQYDgX0Zqp1XgrOE7pJkpiI5YKpF5YwIaL0wSE=
X-Google-Smtp-Source: AGHT+IEX31B+vnAfoSLjyGXBD8bVuesEOcADhBHBxTxC8gtYOWYnnSY129nnbQzIKP7XxPYyOT/dYQv10JwyUw8TGsE=
X-Received: by 2002:a05:6512:ac7:b0:549:91d3:8e66 with SMTP id
 2adb3069b0e04-54b10d92adbmr2069917e87.8.1743397204391; Sun, 30 Mar 2025
 22:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arijit Kumar Das <arijitkdgit.official@gmail.com>
Date: Mon, 31 Mar 2025 10:29:51 +0530
X-Gm-Features: AQ5f1JoX7m2HQ7klx377WtwcOjKo2JqAfoA1JT9-vMDx47vpJozced7K52opPhY
Message-ID: <CALDPgrtP98N8HQ+-MG166GRbqwa=GSgSSAu7T_GRvOSPBxxRuQ@mail.gmail.com>
Subject: [GSoC 2025]: Interest in contributing to the development of IIO
 driver for ADE9113
To: linux-iio@vger.kernel.org
Cc: marcelo.schmitt@analog.com, 
	"dragos.bogdan@analog.com" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am Arijit Kumar Das, a 2nd year engineering undergraduate from
National Institute of Advanced Manufacturing Technology (NIAMT),
Ranchi, India. I am interested in participating in GSoC 2025 to
develop an IIO driver for Analog Devices' ADE9113. This is a brief
email to introduce myself to the community, as suggested by the
provided guidelines.

Academically, I do not have a formal educational background in
Computer Science or a related field, due to some personal constraints
that prevented me from pursuing the same. However, I had been very
keen about computers ever since I was introduced to them at the age of
11. Programming a computer was something that always fascinated me.
Over time, I started developing small utility programs and hobby
projects out of sheer passion or for my own use. These can be found at
my GitHub profile https://github.com/ArijitKD.

I'm mainly interested in creating low-level stuff, building small
utility programs and automating tasks. Thus, C and Python are the two
languages that I prefer in most of my projects. Operating systems have
always interested me and I'm reading more about them, whenever I can.
I have also contributed to a few open-source projects, including few
notable ones like:

        - cpython (docs fix, PR merged), and
        - systemd (bug fix, PR open).

Thus, I am familiar with traversing through large codebases and
finding out bugs, or otherwise, pinpointing the main "code of
interest".

I'm confident enough that if given an opportunity, I could produce
something valuable and meaningful. I have reviewed the proposal
template provided and am glad to find that the project starts from
June, during our summer vacation. I hope to be able to dedicate my
entire time to it.

Looking forward to submitting my proposal.

Best regards,

Arijit Kumar Das.

