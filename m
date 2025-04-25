Return-Path: <linux-iio+bounces-18654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6859CA9CA12
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71564A49D7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4C248166;
	Fri, 25 Apr 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Itww2kKd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C42557A;
	Fri, 25 Apr 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587273; cv=none; b=E4KHQcXmLHfc89dWoB4p4xhqDgB+/dUcNYn7HhDpeuV19lHZB3zKJ+lU+cfiKEisiF34x3SahVcv02KBm4iM6mRteoyJOP3xBYOY8TqP6ac4V8w3YakW5T7h1mKvkVuAgtNLVY7fZO63U68laS+mTpKulZCnG6veA/PzPh/SC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587273; c=relaxed/simple;
	bh=nnN/zvDCW4aQbCYXelWwSibBHI4kTIF3Tsz0c8cnjC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ec6hExDmGg446cywe9vq9BP1b30d2bJTLqy1RYQxYJ4vIqgN+hYc8If9YzYDXupzgrCVQ++oWrw6MVcM6+jg/drUxAqv0BA7qRz1GjMUOGvDzqHD9mpNWV2pGigTrGa7ARvcXLwFnhrS+LyS1RRyf7Zs3QWYMPxiMWq7m1ftg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Itww2kKd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso4291485a12.3;
        Fri, 25 Apr 2025 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745587269; x=1746192069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnN/zvDCW4aQbCYXelWwSibBHI4kTIF3Tsz0c8cnjC0=;
        b=Itww2kKd12WUOl/G8nWIElxXMUnYVZTEZUjIHkY8fO1iB3vVcjVihsGstcNE2J+IYB
         x9SR0Vl0NeM2f6QR/hrf8jeh3uj9AsF6adp9iEVD0itGGC9nHx6qUbEuWt0p8LLaL5nX
         38dKtM3hSl59VkObz8uZOLh3nUAOPV/7ewFf4OV0RqB/YZYiDp27R+BmVC6EXvLO39sj
         AvHzav1FhEKdIeLkzMWFOffUWStSk56D2LOFUX6Rnoek937haqc8PZZJnMa7MMqBSiXM
         x8S3HghF+sisWNAaglpXFiLNNHMwSpWegl7v46LuFmHeZhcpCe+QQ3tB1+xvxTPY4PIH
         Mnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587269; x=1746192069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnN/zvDCW4aQbCYXelWwSibBHI4kTIF3Tsz0c8cnjC0=;
        b=Bc+PXax70dxQ1SfA1m+hsAEi+AcsYfC62Up7gje7SgLbn1JKFUO44rsD51AAef2vUb
         OAQwZusAEZUKmuL8gfjKEeK2d2SBEJCWWH1bIHQQ52ssqYvnMgzFFbsMAxWWU4UZb77P
         ENIYOc53ErUVBp9U3Dyxjcs/fTqMhvAa+J/5k1qeL7PjhMfCrCDM4Gqfo2q/yvaVksB7
         ebk2ij4KWDwB4ZMap/mm62Poz5vq6Z/itZMWlQIa0yUcXFyFOjmmMMLmR6Iq3h4LkZwP
         SRe67oD7WVUaULfGDaYeLWAciIvd6aMZPrgkzQI7qBM7NqWIDWtmONv8FY5XZSz4UHD8
         6sTA==
X-Forwarded-Encrypted: i=1; AJvYcCW4iNXO0+O9HNoG38Sf48hIFMKrLkmtdhQ9JFr5lsnNK9blrp8Ju7z2TDOZlbEVqeHoI9CUU5wTKLn6bZNx@vger.kernel.org, AJvYcCWOn9SvInhhZpR1qTKGVpMGB8GXf51R/K5UwWsbGogls+bTg5TbrVt/1jsAtQV2ij2lr4t4ekzSJ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2HP3z+Bn7YvC0nU0ydLDKUhBVpMojiCpn4w8lSds2+VAlNZt
	eT0ZOYEQb3Dy9VAmCq5nk4RmJUL0eSD0fXOKxivNtVlQEFR6ouwo
X-Gm-Gg: ASbGncv97aB5GFghpHBHi/NJZ9n4+6qh0tqhwJABUBfs8nBFRgjIy4BbO8uiDZvi8tO
	1SUHpGaxfade9ls2RfKj5QfHWXNLezkLpQNdmsw/Fgc9+kSWRfA13WJRmXKMshapdORQcm5erG9
	T78uXILNlPXY0018D1ipAORzh+363Zae2vMahaffzHrKH/5FGFM/nTO8p2EaIvxBmGrIBmotRs1
	Y+EvtYbKSIRIhJpv5a98kbbOQ4rBWzc4MHjnNm1avExZIYEDkkcjYYwf9o4vvr6jM7zxDgaeSW8
	Zx8upRz69ioqw5Tg1eF4YB27lDVC+gbZxOg=
X-Google-Smtp-Source: AGHT+IH2r2WYk5dSL0KFXawvkk35Ed/5kzDoW5At9jJbtgFTDM+r3IBBvnpB36nXmjR3LgJM/1EPRw==
X-Received: by 2002:a17:906:c110:b0:aca:a688:fb13 with SMTP id a640c23a62f3a-ace71178f01mr226892966b.36.1745587268547;
        Fri, 25 Apr 2025 06:21:08 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed65410sm133823466b.126.2025.04.25.06.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:21:08 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/1] iio: adc: ad7192: Refactor filter config
Date: Fri, 25 Apr 2025 16:20:19 +0300
Message-ID: <20250425132051.6154-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear maintainers,

Here is a pretty voluminous patch improving the filter setup for AD7192
and similar chips.

I removed the write options for two attributes and I know that is
questionable. I am sending this version just in case it is still viable
since I think the driver is a lot cleaner like this.

I also modified the size of the 3db filter low pass available attribute
since AD7193/AD7194 have 16 filter modes, unlike the other chips that
have 4.

Note that I moved a few of the functions around to be able to use them
where needed.

Have a great weekend!

Kind regards,
Alisa-Dariana Roman.


