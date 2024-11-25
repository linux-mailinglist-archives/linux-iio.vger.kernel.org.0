Return-Path: <linux-iio+bounces-12660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA9D9D8DFE
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CDCB2AB52
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F21D0E08;
	Mon, 25 Nov 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iix7l8OF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C201CFEB5;
	Mon, 25 Nov 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569398; cv=none; b=pZp1722myIn6TZRRJdhAWDpqzLDA6f2lMxlSk+t/ocIjx3NXP/db8VeSlTiZPTMYGmYynXvCp31HAWKHWJIDLtoZ3XX9FmcIuChzqLvf5n9y49HtKMix4P0+9GITlEw5bNbV3w5kSUaGlc+Q6tWfK3vOzBmIpHo3lqiPwcL2tZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569398; c=relaxed/simple;
	bh=hSZ9D42DCXdNXSk9Db3zxAJgqStCJbsDMwY5Zoj7h1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgz2NiaTDLh02XWqLMsXzknqlIP8Aw5YquhEzE1zSr3LkHbkVy7QqmaYcMVtjgKf1Sn1gcRQBcQIAhFYHTuMAQU/cdUyaosIXRI62cRhGPBs4+AnDf8nSeAIPHyGDWApy4vZvQzaLjROapaVE2YGNPzzPD574E109HZ7O2+cy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iix7l8OF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-432d866f70fso45572165e9.2;
        Mon, 25 Nov 2024 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569394; x=1733174194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6u1xUoxT7/ttVgdl3+avnneACc+sS9I57AHCvaI6dY=;
        b=Iix7l8OFvjt89KUU8NIb/w32R6qreHx4AB7BQggD0BkFey1GSuRlGYH5akDlkyyfOj
         NhFgUJfJJ2OrK07PU7V8EdPJoe9lEJfn100h6iTJw0gwdESl/I3RHWAd6SHqUatB70Ju
         GutWLUktI220jQHjPEOt5swPfdRw+Dypx3hGVbAyewXxFdpCeDXRuqQPfiV/M6kYYp1x
         QZ05+tUvg7zoT0bLpSZTGYoU6BmyQl+mvTwHQcBeWC+8WJOYOXwLsiJY/V17NvoI7LQb
         /j9nbBBofSWcI7ijZn2yWKJ4WsgcrblKVYXZrP8UdS5C8GuUeYyMNusdmcFxttYfmiIM
         b8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569394; x=1733174194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6u1xUoxT7/ttVgdl3+avnneACc+sS9I57AHCvaI6dY=;
        b=qIzpgbjaBchVX4GgXSyRicSdXSCk9qCc6C1FIc4H6zrV8xKWFvUhYC0vc+krpm3wF+
         BeCrTVSJXO9lhSIkdgkNIch9PrbWsme9j4vRPxVsI8DpG3+4bG/G/W8XTPwaQiEMpyuu
         M9OHQirBlkwfpfFJq2gKMS8PjjA+ipcKCJXq9wnR7ge6zwyTjQHRO1x6xCEnTlPmgtJj
         nLpr+I0BuNjkGSXCidZB+NQ2NKP5ZKKjOnmjG4EmxQ76gvXQt9Nxsyga4ZnOA5KY0LN8
         6G7PW+hnBXzL9YPFPADdQu7Q8x7mPEgT0jbEv5A+JiCbTjIJrv0FqhDS/EwPXNnk98zA
         4k7w==
X-Forwarded-Encrypted: i=1; AJvYcCV/UVGqxQYd+oH4l2MDc7Olyw7xrsExsG3FZOHTqlDMFU+CTA6j/Jjt+bM1ggYOvPkIGeUX7EmLNnc=@vger.kernel.org, AJvYcCWdM6DxTzUNAo9W/CoLOxHEiz+nv0Yjq2NC0YBQNLzl2gA9neXmBDUEFaIhThcvA7oG5kt8oAFSzq1vl+X5@vger.kernel.org, AJvYcCWv2NbfZPjr861zmOJtHnhyizEyT5LD+E6jNQ1vzuLQd4NsZQOtRQVHywh3sTH6C2eUgnvDM4NX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6g1wTgXj+o5LtMVzuK88oxHs68+fsFEZkiYLfxL36/AW9e9J
	BWFhTC2MfMwtE5aj8RrEKcRNX3t7QnxLnCXaEJ/cUOklcwAwDk+xuE8XhQ==
X-Gm-Gg: ASbGncuCDhygANcS2xMqgCvNUc8SxARNh5sZn642uKnptylhNhrKjrdMlmgHyYaZNHv
	NFg5tTi70j4F53ZtYBqaVly/VPMFTkrmyAh/WXp/vYwFh3yjd9bcDGfE3SWZ80gV+LDytzbxDTP
	kPaVULkjS5rh42itw0mTvFWqdO8fqVSDU1W+9SwzrTxPjVvL8oUc8772Ne455x+5Kpoq6qBhmmO
	PQoEE4NK/Low/Oc+15YaTHjlYzBooE3kwB8dACs91KjN00FzSV9I8BbCik0lbiKrG2vCN2HTIt7
	SAEi2iFRCVcsYKZKiSvrae0QcldNJynLQAN2Z1sJPxjAhOmLHRpoF465zQXmUGkmgvFiD9yK
X-Google-Smtp-Source: AGHT+IHXtGM2OTKff1J6AaIz33hnQz/oEeFuiMDpyooLhA2F6i/f9BsEYwTMX4bOWfhUIl22zDB1Mg==
X-Received: by 2002:a05:600c:6a06:b0:434:9fb5:fe04 with SMTP id 5b1f17b1804b1-4349fb5ff09mr36454615e9.28.1732569393934;
        Mon, 25 Nov 2024 13:16:33 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:32 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:15 +0100
Subject: [PATCH 07/11] iio: light: bh1745: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-7-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1030;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hSZ9D42DCXdNXSk9Db3zxAJgqStCJbsDMwY5Zoj7h1g=;
 b=Y9aFJiGStPlIN4TBMvX/mUUwKdt44sEwf2i5wpLeVTHVFa9XflKxxn2XHxHuDZUv40AguIyku
 Ufc/5GWyPA3ASKt3Z1HIye92Eeo2hJuxtfMG2VEJCVR6A8p85z9nQfb
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'scan' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/bh1745.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 23e9f16090cc..2ffc839c7501 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -746,6 +746,8 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 	int i;
 	int j = 0;
 
+	memset(&scan, 0, sizeof(scan));
+
 	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
 				       &value, 2);

-- 
2.43.0


