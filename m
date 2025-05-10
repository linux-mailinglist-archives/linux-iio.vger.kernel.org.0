Return-Path: <linux-iio+bounces-19407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E4AB251E
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 21:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D741B649AF
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02002686AA;
	Sat, 10 May 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHoSzX5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12A1428E7;
	Sat, 10 May 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746905218; cv=none; b=OQGAuylfLRnyi6TGKFebrksrmWiEbwtulu4GNozGFm3QXs7V49ky/W1OKLXqy+RG6CE1SrynCahsE+PcHTgn+39PS15ylsqtjslmMPbMX22UNjJZ1Y4K0XN9/YnXUgiXba8sDTWtspxcPt+9Blt1QTctoZ+0iyCC+FMPncmM8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746905218; c=relaxed/simple;
	bh=bcj/X3NQQKiRCWNQgau3gp0LJcKkKCCKGjvzRGukiKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc60NOqHD4c7jDqDxrOr9S7HToHi7icA8bVX+xaxkgq0QTM92al9MrwOlg1hwZSRsE+OxabYQkFhtlbv2ncUlpsgH2YKHfZFHdF2b7R7EpnGe3UQltb0wNtj4qZ2kGDkRbqQFAoiRrtMxQfTIlbArpUQqIAWbgh1iA165x3W+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHoSzX5X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30c3a038acfso2799132a91.3;
        Sat, 10 May 2025 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746905216; x=1747510016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcj/X3NQQKiRCWNQgau3gp0LJcKkKCCKGjvzRGukiKQ=;
        b=PHoSzX5XZe8Yd/rcDkqNfzDxAPew/IckhBhgYFV+nG/jlN73riUkTwoW/E4pY7bVty
         VmMOofBBjIHyPNKf6II1bO+3XuVc2RNEwmfx/dWKGinjJV3Tt1fsIpg/18Z8Qw1pgjv6
         z0raK1XtJ0NryuVZYnp9PZLlLP5/e8rr+9gxrdEU3JfWn6kgfRHk2IOZYIeOOJ/HwWir
         btq48qOXb8M3YhXdS7KdOKJpCKboCWamv90yKu6ydW2fvOloI1yMMP+W0w816cnH0VFC
         HN4B78SUZAMYXVRyvRHq+kfsBpkUcOHKmD2KPgBlj0P0meCdF3fdBTtg+XiLLMjnJLrw
         NoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746905216; x=1747510016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcj/X3NQQKiRCWNQgau3gp0LJcKkKCCKGjvzRGukiKQ=;
        b=nQNyvCYYYaLzLiofOd6LI/ADtfShA+iL74Zpg1G4XM6LckF2XZiuuf2pwIgZFESBmD
         JcF8copzOXmz/ZFFxdJMwQRSXobM1J6ZBHieIV/PQRXRKgSyrWuipwETE0VgZjHVLp2N
         SCF70iud8nuiKIHfZJlJ7evYUVw37y5V0buGEW10LLMlOZoKKWoQfnIcwz0C/YCz1k3/
         4qEIAJoHYeEAg8tTY73t47Zyair8SIx9qK1lN7fK/YXATWaxHVRzjfMafzm27ElqsG/n
         gbDVNmPrQ16rh5gLhnloaBJ4vlv2JxRkrQ/ze9jg5lQ1rtb7MC0oYl1qdMfqGbnCqiv3
         RqWg==
X-Forwarded-Encrypted: i=1; AJvYcCVFMerwPIr8yhpaTPLvWad56TqCuR0uq0J9KBQWxsoyzF29Pw/EiDR80Rnh+deyePTKs7ttRF+ujC4=@vger.kernel.org, AJvYcCVjzo+2Uwz9slM49Rzzei/D70RbZ9JmsXfJ/GpUdht1o8hGC11fzKOaUMMv8Q/e1TvrRF85WziMt5cAs7G/@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrI/OB5VNabitZIgET1pF8zqv/vv3PYlQaMvGZxbLaWVfvRW4
	Zisb1vLoqTMf/wJW4FPO5Y98PIPr4s1k974AE6JMgT/gzXO0mrNIgSmuTRTuVQuWl76FUruw3Av
	FpyfWPcwxTzDVEIjguSdDGbDo6hpaY6dK
X-Gm-Gg: ASbGncuJ/UXHJkUui7nw8eIjhfq7NxAVNNDg9X62w1ph6yetZ++VaEVaO45z5UrpgND
	dJtzvGOyFoaWe35tZmIJSZ/CMUH2Qt/UCKBRgvPSHd/5IqWe7YvxHvRe3owMVbqPsJ4k2SzAm3X
	10EgElwusAuqFy45NBI2gwJnPjDTDKNu5RDQ==
X-Google-Smtp-Source: AGHT+IGrhXtlVVEciHcPFTbAk+wBjbumVRggzoQWtgXyfCyyfzQMnfec/ZV6Ao0h3Mb5X/WRbAgcuFYXrBfZBWU8rPQ=
X-Received: by 2002:a17:90b:1807:b0:309:d115:b5f7 with SMTP id
 98e67ed59e1d1-30c3d628b4bmr12976444a91.24.1746905216501; Sat, 10 May 2025
 12:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503190044.32511-1-gye976@gmail.com> <20250504152441.13772899@jic23-huawei>
 <CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com> <20250507204026.11a260ef@jic23-huawei>
In-Reply-To: <20250507204026.11a260ef@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 11 May 2025 04:26:45 +0900
X-Gm-Features: AX0GCFsG6PgGtzB3_8O8JLluNnvzL4cLhAL3S7w4CHtOkkGICcNnEpCPQ1Bhv20
Message-ID: <CAKbEznvL3QbmfNDJsa6T2m=t+_JS=fx89WC7LJ04s1ecg2kH7A@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices requiring
 top half
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jonathan, the example drivers you pointed out have been good references.
I appreciate your detailed comments.

--
Regards,
Gyeyoung

