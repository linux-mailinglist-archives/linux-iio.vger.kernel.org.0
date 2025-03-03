Return-Path: <linux-iio+bounces-16300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE2DA4C8CD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 18:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71976163A68
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82142505C7;
	Mon,  3 Mar 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXWFBRWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A942500C6
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020378; cv=none; b=OTpYhCMj0bFKhRfi+BqtfQ5//9AdjlzNc5Hdj/8TtNqAOP7jvdgBvbH56u61R1ioSo0cMb+cjpY7mqgsHcwZwVAhjvFHnvqA0VkJKxyDywC+2qB5HJG7Z0WdFMhBuZzRf5Pl1WY2ZnNaiEjnC29HBsxDnRueUwVMZKPFV9S2fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020378; c=relaxed/simple;
	bh=vwKffkowRqqKxqcMgwNp2ANqImGns5AjArT8r15Nglc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vEtJYQdjgjV7nJsu8rQXLhUkMKEsZEsd7d+iu9X9+jM5p2ajns/cQYEG3VQbAXREzj971USTXlj1fQWbE3BtIUaQ65/lJPbTvCfAOF376J/n52e7b1qKEdBwo5YGNf0rS2y4LBlSL1ELYwLXSwu2VVPmEbjF4AH+cTxA73X4ULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXWFBRWn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fee05829edso3849554a91.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020376; x=1741625176; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwKffkowRqqKxqcMgwNp2ANqImGns5AjArT8r15Nglc=;
        b=WXWFBRWn5VDHjrhUV9XCc0ICo5R8bx1ISRCkdQHp5l4/XBs8g8RyJC35dM0cmdWONM
         ErndR3AkiRgadaj+RBN3eeUR1IFT6Zy4biMiWqbmRC+XNd6jXwruVKx65ACE0IlOw1RS
         Kvm95OYEPo6CbJPW3OHVCA3ucnR2pMmVr+s+nh3AgEBKxNc0B2UzpyQkbm+jQzIIC19/
         rhKBPtEzD7lAYh98Fti4l6B2nKyHxUSqDHQW+vk3K4qQCk70TqqC+xxo9k24h0jaEWJn
         gBcwqCQVnws2sOFp3NAsbWDLGKTSQZ3EYlQx07ggOj9vDPtuZz2a0iuqVlaH6bqxh5Lr
         DCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020376; x=1741625176;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwKffkowRqqKxqcMgwNp2ANqImGns5AjArT8r15Nglc=;
        b=j7SaS4moAtob1rHf64hKZmoYOeDNs3Or5VSQG7gjnhfiQFu5PTI4xWVqwe+APb2cHp
         Wnvan4BKzzy7UkZewXc5oKb9SKLk29UxnApHPeIenoOT1ShdGwCE5cdf80JqrzXb3CtH
         PoAMO2/gmRYgMoE1cbUREVygvyEjc8gAHR8MEPvO+JpwzJg5u/QwRlHVku14BiCp8VKj
         nXYE1qDYddtXiWyh2DFZvudC3JaouD+Xk87MeUHiRYrRNA0CyXfBVFys/x0xfw5gyja2
         bSbtPJQor/2uYnrtYiMb4NwOYzp6BBp8cRaTwYycITUf+7BY6SsoNTOqTp/rBcl3C5rD
         huGA==
X-Gm-Message-State: AOJu0YxEk0Dwx1zYfEawn2Z0NH3GZC79cNXpfgTLemh7lpE7JzHOsuIG
	MKBgurjf0yzIK6Qkp3mrOjW5qL6F6KpMM/FoRW9Tc2kuzgtKQEGd6d0sshOimJaOiZOfR4FuCcS
	erMJaMnWwhOr9VQhyR1mZPdYgl/I14OUL4Zobww==
X-Gm-Gg: ASbGncuSy+7S9gv9BuwrtxlwUNVd0hgNou1fXjBFT0dC5U6CX3BvYry43q5M543tcBE
	W2loiMHM7kfOCtmGVIlcDxz2jmG0awi3tTNhWuibqF8rNGnthXdthFnwjVWBwv9CnKhZJdOBEGA
	z8L5Gc+8vl/hEyqMCTawa3s2ksFA==
X-Google-Smtp-Source: AGHT+IGP4+dX5KiTDpTpn2dqRU/l4FVHCxHpdL9g3hGpqplHFRQ6GnCf1WGBp1y4h0Mwo8g1gmNuw+PjDOpsXDV9eFM=
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id
 98e67ed59e1d1-2febabd9c6bmr19581637a91.26.1741020376087; Mon, 03 Mar 2025
 08:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prince Kumar <855princekumar@gmail.com>
Date: Mon, 3 Mar 2025 22:15:38 +0530
X-Gm-Features: AQ5f1Jo_AFLQBceFU0pXGVMtviDmkSw1iT4apDrSSF5hh6s7otl8IPnjWu2IX80
Message-ID: <CAMmuoA+1Qi2qnF64nmHobL6hSFdf6GUrX=BjZ=0aGULu75b3GQ@mail.gmail.com>
Subject: Proposal Discussion: ADE9113 IIO Driver Development for Linux Kernel
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux IIO Maintainers,

I hope you are doing well. I am interested in contributing to the
Linux Industrial I/O (IIO) subsystem as part of GSoC 2025 under the
Linux Foundation. I would appreciate your feedback on my project idea
to ensure it aligns with the community's goals and best practices.

Project Proposal: ADE9113 IIO Driver Development

My goal is to develop a mainline-compatible Linux kernel driver for
the ADE9113 ADC (or similar SPI-based ADCs), enabling seamless
integration into the IIO subsystem. The driver will expose sensor data
via sysfs, libiio, and standard Linux interfaces, making it accessible
for various applications.

Technical Approach
1. IIO Driver Implementation:
Develop a modular and reusable kernel driver for ADE9113, ensuring
compliance with IIO standards.
Implement buffered and direct register read/write methods for
real-time data access.

2. Extensibility & Optimization:
Design the driver with flexible Device Tree (DT) bindings, allowing
support for other SPI-based ADCs with similar architectures.
Explore an MCU-assisted vs. direct SPI approach to evaluate
performance and CPU overhead trade-offs.

3. Testing & Documentation:
Provide unit tests using kselftest or libiio to validate the driver.
Write comprehensive kernel documentation to guide future contributors.
Ensure compatibility with existing Linux tools for IIO sensor data
visualization.

Community Involvement & Next Steps
I have reviewed existing IIO ADC drivers and the Linux IIO framework
to ensure this proposal aligns with upstream development goals. I
would greatly appreciate your input on:

Feasibility: Is this project a good fit for IIO and GSoC?
Driver Design: Are there any best practices or existing reference
drivers I should study?
Additional Considerations: Are there specific IIO guidelines I should follow?

I am eager to receive feedback and refine my approach to make a
meaningful contribution. Looking forward to your thoughts!

Best regards,
Prince Kumar

