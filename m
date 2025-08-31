Return-Path: <linux-iio+bounces-23534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92527B3D3D2
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EE4189CF3E
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280B26CE2A;
	Sun, 31 Aug 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUYneVwl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82292571B3;
	Sun, 31 Aug 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756649317; cv=none; b=NQ4ij4tq+zoX3Xn5DJww3NZjl4Uy9+RaTYNuzYkFoAoaa2QrGZL0HxvScdKxYeF+Do7+zR00HtecQvaII0lU46H5ZVUXO0ABpCAbVxKLmdek4g2+9LyKQ68+cyRhuD9wNOSCjxgIbv6rJ46x1/UAv4bI4MWUcqMMXTMgbW8Wz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756649317; c=relaxed/simple;
	bh=GjLusGNkdYs/MERz7kIO+EMfWH1v/KUmPBHaTmX1POY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EW67NFH5wvrfsoTaENgbNcISUU5YFsnnntrfB2MJSGsdCpdevq3m3bmPecK8quGgqagSt0kAJMst2bJsXQj6l9/bmbq22LSePHzIjnFwfE3+Z+Mt2E/CdNpC16umNfsPY+qXGKpEMXauB2NTRRlyDjTbKpiVS/uJbpnkQ04udYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUYneVwl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cb4370e7bso5271172a12.3;
        Sun, 31 Aug 2025 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756649314; x=1757254114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjLusGNkdYs/MERz7kIO+EMfWH1v/KUmPBHaTmX1POY=;
        b=DUYneVwlAMuReOOXM0Z0Fck8oi81nI6qo969wgxVTOEg9Tdx8f5QwWi53YhfSeJlSC
         3R4JgGQRyJfbmaalb2K4bX7zzDG6JmIA4tI+oMK1U1qA7peI6WeO9USm/KAYD8Ld85A4
         NHQyUf+YLoRONFfAQB5DzE27/tmhR6PHoflUZ1fyROqZgvsAT6mtSzSQnvjo9ZbLPNcR
         NHc+mNGrcrwAurDrnQQpU9ABFHVciWlN4nq6+DEZbL3hoZweQ1ey7AUvcALmrBjF2TVe
         qenQxZ5/39wdvIVg5Ndhr845/xUIJlsLziEQbULrlm35Uo84RGVWza1RMyWDlP8liREz
         eFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756649314; x=1757254114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjLusGNkdYs/MERz7kIO+EMfWH1v/KUmPBHaTmX1POY=;
        b=k0kdsM6NLFNDP0gS/tDlpa/fsVXrEby889cC17GtAm3t2gDKJABfQS0pwXw3//d/if
         rlqy66b4DKraMsv07n9YoNKXgdmHF/RoDxQMuJn4djzrZU3vaEyiYd7uiWII1fjOrDr2
         QmuL83E8HwYBP8HhJ59FJ5dkVTW1UAaJijMgCV4/TbOamyfZEX9Ytwnw6MhJxlheIE5n
         ueXvn9UxRKfHndLkMn2OJaxdxYED1t7bIbvbB5rafJ89Bf4WzMwke6Ut3qfSrj8KqQmF
         FpdkvX88CEJ7LOWTExz4X8YyVSwhwsIbK/vcPDhKWcowaEcnQWub6vG9wG6gjjiz4c08
         g6uA==
X-Forwarded-Encrypted: i=1; AJvYcCVK20GOEo/qL5IVbwyECfPJFAXGOWc+K3az0t6GHLWZzvMsqz5LTbhtJ0RdyvS1/48+6+0PW5R6qGq5@vger.kernel.org, AJvYcCXhgoeIYyH5USxkK1dEw4cr6K5oGgz6reEpTmPI6mH38hcw4PWbLwVFf0QX17Tp6pIt4rKI4P5Oecc2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5By7/jkh+dA3rAVz2CnQ21VmmQ4smQi+5bZgseSZ7sR2wxGm6
	2YN/QFHNJEUQfLy/aBOrFRRgK+8kmZrAXBvyLh/zgEpOTFH4ayxDrZfpjt17ueDOlAEKreDwXRL
	cYqI8xjM8MlyZ811xzvrp0np9zupgF2I=
X-Gm-Gg: ASbGncsrs0Z0NLqT1nhP46zjeXim6ryxB2Hq2X11GpYKhJDdhTVvVPqg8jyd0CL5Zc4
	ZQZROb83dldzr8+SKPZASRFmZNqnNiSHKj7L0C0v1Efdj4ibL5gXLVdiyTXiXn+7GAyin2TJqxh
	YUrerEqIZoUNi3ZOvASRrvQ+E+zUeOr5Hh6C6rbXu+tPTLGN6yYva87qM4hOtcPT26baBa4uBLE
	UYVUuEG
X-Google-Smtp-Source: AGHT+IG/MVs0EHefFWoKpTsf6F7L8y7uVUhu6dM/Bx+qW0r7jc+0k+yXbITcsYsA6Tv4zI72wleimf/thzmywxP99fY=
X-Received: by 2002:a05:6402:27cb:b0:61c:3703:351a with SMTP id
 4fb4d7f45d1cf-61d26988c5fmr4167380a12.5.1756649314017; Sun, 31 Aug 2025
 07:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+Ctp7sps9yhyagxzL-SJYfyN8mPSz87ALD5XOZqYMru7Q@mail.gmail.com>
 <b77f90f8-5017-4137-bc8a-57229537e8b8@kernel.org>
In-Reply-To: <b77f90f8-5017-4137-bc8a-57229537e8b8@kernel.org>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sun, 31 Aug 2025 19:53:22 +0545
X-Gm-Features: Ac12FXy-giMFaW3n6gYTJNIb4PRQG7UDnCwqAPgPYBvQ0TsvXHJcJv8c5HBRvIE
Message-ID: <CAJE-K+CZ4TqaN10KuRZ-cL+mvbZSHt9toGDrQujmfgkqLHn-XQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] winsen,mhz19b: added compatibility and of_match
 for mhz19c.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 6:38=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> You patchset has broken threading. Use b4 or just git send-email.

Ah, doing that immediately.

--
Thanks,
Sidharth Seela

