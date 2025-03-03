Return-Path: <linux-iio+bounces-16302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B50A4CAD3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124853A2F14
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52885229B0B;
	Mon,  3 Mar 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQqgyw/B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E9148316;
	Mon,  3 Mar 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025245; cv=none; b=qiFvNewAdJqIaVAaMJaolFGF6WsSBYYKgPwrzQCYIgOxa8tk4V5D4yRDH/jSqG8hxLv+/kXeOoz4pirjYtBYqNn+zwi3LXaIEHHLFa+CB9bKsXib5ijvzRZSfTrY98vIA7F2kshSX2NUj//SPm1hvxCiCaL1glNSKTssDWSfT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025245; c=relaxed/simple;
	bh=bXCU4NzMCxXhDEY/l+uqvwrVqfn0ib2oqzKftnBQaMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7/A1Fj9PHjsdvULHivhLPvyrlHQRVbXOcwifAMKxqpZIdFyKgoCQZ9pZVE3YgHzr/3Y//a2akWJWpsGHvlSnI9NLV0K5RK4TIP6Y0PwSS0zqCLKdrz1YzgOe5yUhKV3imOS3Dx2sW0j341kpvVY8H86eifhvksRUagWfNap8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQqgyw/B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so88411905ad.0;
        Mon, 03 Mar 2025 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741025243; x=1741630043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXCU4NzMCxXhDEY/l+uqvwrVqfn0ib2oqzKftnBQaMQ=;
        b=QQqgyw/BmtqX9MEt08LI6JpwZobsAie0KlcYLXp2VTiQY8sKgHrTaXI1Jl1KNTLaIc
         ePyWVlCedLluMFIYN+aXnUux9hdftBuqnwQLm2HxY9//I4iYoX8lv8MgyHy5PSWEwqx1
         zrHD+pEg6iJUdFxdm2/BA2+OP2a1FyqQZXIoDmIaYze6xBM8katNj/osln9mrFXZ0bii
         +J/Z/GTh2wsXKLBMTJo300DRXmLnUiFa6Xg34KsnIqeg/n9zn1x0H9hCXLT5WLwLS/VW
         /SPXaNs186zqbE//CPqFpmCPt+uZwT+H0VsYtLW/yRbTht+DTBuppJI3PoB9FavIEYWC
         fWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741025243; x=1741630043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXCU4NzMCxXhDEY/l+uqvwrVqfn0ib2oqzKftnBQaMQ=;
        b=CnJzUhyeLM2xzIMBASqJGnF9I4JHy7J3BRuxz1ArhN8veA9lfbwchMPzzJY+eVZ297
         UYvGYpppa9+t9Lnkkbzx14fc8cS6dbnQBZgywf12zbUsDsUCkCYc4khIVe/ODRW9g0RD
         WzeXDS+f3CxXuQopzkxApFXUizmOik9CF3X3lra0rj7RLuj8oVxbZ5XHT3sQZaS7G1Is
         ZO3msdetlk3/NvThrK6SyYVhGpbjJf4sRyI0/50aSDxyrDp11gGdoDIGbW0V1Z8A8ejp
         MDCn0JZhf8xvXs2JhvBFx4qVgKDs8KpvL0jYe/vwV47wLXZa+MxypNzx9U+B0iSN513V
         LFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU90WgF/txWClRF6fsM/8+Ti2qZpFIPj5/+Y0qOzFnfeUAfh7IFXnnO8c2RCLnDJgrXE8kWcipt3onVTdaS@vger.kernel.org, AJvYcCXRB39pQdC1LynnzR/CXMe2Ucatbhtn5eskaMHAXIiVjUTJCK941B6bDDfUzSPaOdp0LrhAtMS95eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6VJFJ1aeqVC0AsysqgnS+m6xPU0snoFXCvhuuq1QcR7S1NOi
	VoSAPcwwu0ntrp5xdhOQS5EqdPHEZZwv7VigYqS+GRg6kBoLybpY
X-Gm-Gg: ASbGncvLvCmwb8aqsm/ANkHWubNmEOM9SHNhh8SOvNN5iBVofnuZl/rqtNpMpJbzrRT
	0FlYfeEbP8oiylb4jVCSoIKlDG0JLNvg6kTlJANTXtoYInE/KkDINBAsf4IRsbUaGGoB3PObeZb
	AXsjv/6O1YidgLXXuRwXp5ezgUJmaTehZxwvNd7I5kMZazHb7E7kEVSi0m2AgkKH4ZqYEes7Zuk
	VEnbnvA1EgKLmo/zLdNiosMEDDnGiltpgOq6ZpGZRNwMfDLY7VeqjUBNLNhOlWQE2/iUw4WPG0E
	0K5TyfvPHSHKQRfYlUW4esX2kg4cS9HG2FXMe0klaybbhOe4qQAO99LYoheR9VWihrDm
X-Google-Smtp-Source: AGHT+IEoXyqJu3mPpaYJ67JbiWewUJKm0tJa4OQ5m16xsFToWnwkVzTIefbURvOB46dYpKI8rulCgQ==
X-Received: by 2002:a05:6a20:1591:b0:1f0:e36e:f58b with SMTP id adf61e73a8af0-1f2f4d2250dmr27131962637.24.1741025243002;
        Mon, 03 Mar 2025 10:07:23 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec3dfasm8452216a12.59.2025.03.03.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:07:22 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Michael.Hennerich@analog.com,
	danascape@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: ad5933: Fix CamelCase naming
Date: Mon,  3 Mar 2025 23:37:18 +0530
Message-Id: <20250303180718.15707-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025030301-niece-evacuate-0f05@gregkh>
References: <2025030301-niece-evacuate-0f05@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am so sorry for such a silly mistake,
will try to read before sending patches from now on :/

Yours Sincerely,
Saalim Quadri

