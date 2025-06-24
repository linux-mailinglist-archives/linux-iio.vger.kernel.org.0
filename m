Return-Path: <linux-iio+bounces-20940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C6BAE5F3B
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE58B1920D0C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E90258CF8;
	Tue, 24 Jun 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aacI6M5U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CE2586CA;
	Tue, 24 Jun 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753703; cv=none; b=mrScoK6EyrKaPcG7dZb1OekGz5AeVpgIodiGz3udA4kYxBiBBv+c9kSMNY9nb0nYHHVRj7LzU890h/fDVP6kYgX9v9vCMmnHl2bvRS+aNtSpaLVkOzWcqAIKEpkDulx3PrCojciQRK7g2ufcVvvQr1/sNRl3gOFGrFvbn40J84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753703; c=relaxed/simple;
	bh=BrJ38doQTNTOqQctJA4w4QZzc3In3XQx97vnQ/UdjR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATtNZFmb1n7QfPR6jDi7JkSqVDYJSHVy2h1w6VHAsBWBSPffCzLJt/18sd7/94CFQXOTygiLI8XpPdQhAHZXnWCu9BNHspPR7/c4a+MM7Bw82tpo8G4lwKj38hp7TaFPJFTM2ls3xKVjE2Jajkv5S5krNqnuiGv3WWip6iUJ5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aacI6M5U; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8187df27f8so612505276.3;
        Tue, 24 Jun 2025 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750753701; x=1751358501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BrJ38doQTNTOqQctJA4w4QZzc3In3XQx97vnQ/UdjR8=;
        b=aacI6M5UjORXb2/schId/9QnQcXgOZxaCND6248AoEkXaL17Lg4C1n1p8kvn0qWu+m
         j7iZmMwO/O0VUFt7OhvC5WGDAApxw0F5kf3EpC0CYbQ8fWj2Ka/uQ+l4nDSMCkwEccCw
         QD3GEzZoaHX7mq1V+YK8c4ET+Gzo6d2FjFJRIPdrv2f12SQMU3MeDMana6BpJMWENfCr
         a2eTQBke/QDIVFAnifGfwJUOOoBxFNyewTa8TaMedwFxhUD6X+VMsOoMh5MuVIs2oond
         K7xK+Wsqih2MDlTbYT1G023d6aficBzysNLrmiFv1TJbQH34kPMmGWRg50RvGDUjYciL
         HGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753701; x=1751358501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrJ38doQTNTOqQctJA4w4QZzc3In3XQx97vnQ/UdjR8=;
        b=uUCIeB7EbXIMM3qRrcGVZgm4+Axr4nKBWyWwAqTNgBdvaaiye23WEPbD6e1c/MRnVl
         17YruFlZoZWSGARf0prD9jCcOT5W0QhbkC+/r9fOx7Ys15Cc4pp27NIw0OPGKQ8dzcHn
         JR9nDBSb0VdQmIYFuuZfd1o9VVz8UWLpqyIN9XIgYotA/dWvOtfxRW1oF0d99yXlUM38
         j0CWq9EXooJVgqYDdV3A+N/VLn10h9G5zCYsWKnH2z4J+EYTEkKEIhUP0V3WQJbe4rX6
         +jaiNubqZU+T3xYtoYk/HfP2GR3RB3yVCAeMJVUu49m+ka4pdNAjCB4tqRfozmpjoSGT
         b9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7dCNw3x0lqBDOOz5kVFWMH3TntZ4GHVL3znP71o4dYx6xEWH3dTdVj+c3MU7cLjUE5DIXrcchvsPj@vger.kernel.org, AJvYcCUWrCNiqunHSd4lsqkxo5ZNVT9cqCgPoF2vQLKW2qTtESulfl3qU6vqCb4ggHhmPhuqyrPm2+wsvpU=@vger.kernel.org, AJvYcCVa+93HEtfpR62vsP5M8wqd0z1g9KzEAJlCoPUcMFbgHT5K4RMJ9hhlH2hhKgYmXm/u070GEZV12nUbTst9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzm3mQhpfeLUCFITNHeqdNWl7egr24ksKkiHulI57bjvUpY5dY
	xmpKF6wIgQfiZRaiToy89cOErtxADrP56vE4FnXQH3O5OXraJjAwbyw+6QArL5WYDMMDCy7WWl+
	lnl+qBO8g4Tjxa2beFV7Iia48yJ/RgpE=
X-Gm-Gg: ASbGncvOsBNntPPIG9OSvwOeCmBH+eGp6YG6MFVqr0rxgvlDFhkOGjeqdv+tdxi5FsT
	VRTYar5NIlUesGkKm3JC2BsV+Y+VvQcsd+BZqypCEIxGCD62KK0mWJzbjV2KItPNQY6eWclqYgR
	Ki1Cta7SQQjQBZmCqCR4zrGb/PahRdG1QT5i7b+AEYIxc=
X-Google-Smtp-Source: AGHT+IGCDUZ76ytppyTdkWKZ/FRSn70DwObZjMPGtzLGEpQ2Hl3CidDxu8Sju2B/RVJWDI0TMNAQnLBWPBcHBBZCQDM=
X-Received: by 2002:a05:690c:a0a8:10b0:712:c5f7:1ef9 with SMTP id
 00721157ae682-712c6767523mr74074337b3.8.1750753700800; Tue, 24 Jun 2025
 01:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-5-l.rubusch@gmail.com>
 <aFkh-E1dG__p_G4m@smile.fi.intel.com> <CAFXKEHan_7+BVshb12JZLH8CJtSPuwv=H_vC2kUWkS411wsqaA@mail.gmail.com>
 <aFpUsv5fWYJk4vxW@smile.fi.intel.com>
In-Reply-To: <aFpUsv5fWYJk4vxW@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 24 Jun 2025 10:27:44 +0200
X-Gm-Features: AX0GCFt8Nj4tRsRK-Hx65ERcldQO7Qyp1Spa26kzOarIL6G_igIWXIZWmJkTt9c
Message-ID: <CAFXKEHav5-Mo8uGd2WncrzvekH8_7005uu=6Z-TmqBBFjPzqHw@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"

...
> P.S.
> Also you seems ignored my ask to remove the context you are not replying to.
>
Sorry, I did not understand right away. Now I got you. I'll take care
of it. Thanks for the advice.

