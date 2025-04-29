Return-Path: <linux-iio+bounces-18871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA840AA1AC3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7931BC1D4D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C9252905;
	Tue, 29 Apr 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG4foQJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73B10F2;
	Tue, 29 Apr 2025 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951875; cv=none; b=Xy31JncfhH7PJDwiH+rShmWsfwQ34T5gKDn1XSkx0HH0/gPVYBC9CVlbS9hXYDRIfWS37PA8YOAQ5ZosA85Q3VyJt64SsKTXeFxGCCwVjS+EmhbgB+lzkIwr30pbpIR6+jobqyeLiBel0sV+50WChIyaKYtWKwcSIHug5JG25Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951875; c=relaxed/simple;
	bh=yktVCvLC4DmKyBh0OTgSzYhGkg+Semk26bu79lO5l2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+p30jyTofK+DyH81fPG0PFHKQdcAGw78GVcUZ7hatTjXHT1DDz5GYt2wELxPKXtNoJ/BSVUDuUi4H7LBFvVg3s1aw2523epjv6QIwSWiGqwZgI7eedll/Yupz7kk08xwoAJOa1iUbe4WYS5hfPZCq0aV4/srkvRAMMl0s7A3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG4foQJ4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549b159c84cso7324835e87.3;
        Tue, 29 Apr 2025 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745951872; x=1746556672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yktVCvLC4DmKyBh0OTgSzYhGkg+Semk26bu79lO5l2M=;
        b=DG4foQJ4bjnU1qyvWLFhBSpkbvZ+u4ZaBz26wCBUFEdLOwtWIiGjitKIJmQ9SikIaF
         PeQ+rHF4b/K0aGn0TmCDK+w8mwxO171FM1XOnQUsRgjn65AeJGxAKVpU9WbP/vYvFhcm
         IF5Ax/OqAeYV9VvsUeGxL3YV1i8LDUXobBZu/u8P/+4JR4FVe2MbJZ4a9HmYxEyjiden
         dDhpzs3X6TZgqjzBU7DG6qkhqc+CUsFFLSj3LRHgAFvyTc/tITaAFZWfAdBttsZoPWtB
         /TT/tVxhxQzyNDeZL/4qkGJRxQl1On00FhYhkzQ9koHpaxkTHRNxCmgp6jHCQnw4tJLR
         QGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745951872; x=1746556672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yktVCvLC4DmKyBh0OTgSzYhGkg+Semk26bu79lO5l2M=;
        b=NrHyEpgIGtZkLflKNuK9kjNx1Cbp8qSx89WZaAxvgDvbV46gc0eEoa2WPkfW5N8UwI
         zlMRiCFoV3ZB42S64HfVNHhU6gqptyCBlT9UbiPbc4yOJDeIUAAOlxvbQ8NQutriiKXx
         e4D233sTwMAXrzP/TlkAibCS6L9+qVB5jW74om7m8r4+SHSvJTQ4v6vl4AmKxnFkDp9f
         7705xeC39Lt2kZlg7WeruE4raNZ/knEeq1z7dC1LuDFEj8xPF1CLp9sBBfdSTRR4ZZRY
         dejML7dnVsCI3tAWxFraxkUHMz29KcwUDkXGk6Aa+RuGP9A65OSKK4qyYu7hmT64wzSr
         FTSw==
X-Forwarded-Encrypted: i=1; AJvYcCVRxAU5nA5mkt5tuvyTDfYDVDeRLTJ9b9CAZfu3bSz39YxJHuut2J+XAyDsZlG7FeVn2s9Wa9BX@vger.kernel.org, AJvYcCVZWx7JtWNVM8GxTi3lQNKzTgyHF2ZAMY0yYkE4TcisTvKnYnR3feOEpydWVaeidrtJBsRR+fHFqhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjdrLiQ4T7+akjbYQ8Ul8MmV3J+e8jW/pDm4wAIc2DpilIuAY
	kA9UKK8IdsICp9KkOXFGNclYnCDRIqhMzWlOZzE4VRhERu63IdcT4p2y5tvUSHQrvYfm3sft+TN
	71LidMze3EliTShzp5JyW+2Mz0fk=
X-Gm-Gg: ASbGncsOuQa/xJENw9SI2xmGmgV2frCBVSQv7buiwKCYHFTa6Tn/AOd8zAyK2i7UxWA
	UMcjewGg1rvvnZc28+aji0wNoo/mLX0uhutrQkjO3gQsuD8oPnWIm7A+Vey7ZzKF2wJYY1jY2gO
	TFYjcPKrapZ4a2MhyE8fUTzUUefzub28LDUV+iZeWWh93c8c9rznVUzw==
X-Google-Smtp-Source: AGHT+IG/YQEP80lUIhmq5TV8Kdjf6WBJkkc+8cVxHXVdd/gLSew+AOMN85SX3hy96t9o1b0MShwvpU8dwyoJ5iRVjLA=
X-Received: by 2002:a05:6512:3b85:b0:54d:67e3:91d2 with SMTP id
 2adb3069b0e04-54ea33a6f24mr48906e87.39.1745951871715; Tue, 29 Apr 2025
 11:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429150213.2953747-2-festevam@gmail.com>
 <20250429183552.6a87e4cb@jic23-huawei>
In-Reply-To: <20250429183552.6a87e4cb@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Apr 2025 15:37:40 -0300
X-Gm-Features: ATxdqUFbXLfnr9FUkmYzy0rb6dm74_1zhz9ztPqxNML3qJSN14jheInNdroUxtM
Message-ID: <CAOMZO5DL0OphV_qGpS=ynH6ux2dLUX1GOXDb3LCRYhHzv5V2=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: max1363: Reorder max11607_mode_list[]
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 2:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> There are others in there that are out of order...
> max1238_mode_list[] for example looks to be as s6to7 should be before s0t=
o7
> (there are more issues with that one).
>
> Would you mind taking a quick look at all those others as I'd like
> one fix for all of them if possible?

Yes, I can fix all of them.

