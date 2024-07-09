Return-Path: <linux-iio+bounces-7479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7DF92C2A0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0423281755
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901BA7F476;
	Tue,  9 Jul 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCH/zGur"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECD1B86CC
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546717; cv=none; b=fhV4v4xT6M0IK55hpcpJ7F+TCwxa4J/6H4Rgj4aYwp9SzioQOhkMtbJMg/k8UqrDt4m/Pok2srYNFdHtp1HuJ3+26ieYe2RBGTWJ/exusSmAwV3RJbPy2cx2wwKoX356XWwDjtSkXWwbRdjcxiJSx68tny6r4xb2ZM4JQ4iObuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546717; c=relaxed/simple;
	bh=f31M9D+43qExm6zF7mw2MlKFuGMbX7765DkKTQlpaKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JXB1K2N04aMfA2NBDymNZenX7scm+EYL72UFyaTbUTqJEVhznF/ysklvOHeItNZi3xtH1hvq7c/vlthujVsbCYgYmFDoth0rUN/Dwjh1sicPUNqer95cDOOj2X38j0jUz6X+C4sf1706ycZaGmpQ5AE/J8Js+4ONT0deEhwsdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCH/zGur; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb05b0be01so32222125ad.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2024 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546715; x=1721151515; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f31M9D+43qExm6zF7mw2MlKFuGMbX7765DkKTQlpaKs=;
        b=FCH/zGuroatzaI8y9/ikUXyBYfkeFzqQZTXvmy++ndBw2TeQXIGdyAmJTynQ9bJ90p
         cesNHUolFWiREkcbUk9Dd4l/vrVwnF/VuGcb9JcHFV1GmJwG1l5TFkwuFZwYVKBGb54Y
         auMGCWIDcfFdLyu0Qpjv7YqcMNQo9iJQTlZQQhhGxTakKADn5y4lp78bbKHh3ACqRYEI
         ykm+21SJWRShtue9PSPyuxg8Ou63THRh9LICPhZibo4OAJPvd1hAKZmhNCiwKvpvN9pi
         XneuVgvPKjMQf5W+SZbhwxRoiUjGcrdKBuWzV/vHCXOCPiVC/NC6itxZBfTrcwl9ydzo
         D3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546715; x=1721151515;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f31M9D+43qExm6zF7mw2MlKFuGMbX7765DkKTQlpaKs=;
        b=VEOXB0hwsWc3LcNHg6FVFdjb9Zh3fQyUwsuE2bIL4wkHudCwM6JzQy7Y3S9a5aOez3
         wvKXkeklM6XBkKz01QCjxHerXRh5ilucjZ2LDfmlArCtEazHwbdStNzkhuAR48pvRKJP
         ge6l/jlJFBVrMbJ71C4pP7I86lViq3XDoO4J1zOpb0VZjtwkzbtfUv8hydMGqSB8RtVK
         mTGYCWOxx+MjPKIvBg41CElIpo0QZWP8iXaZWDerqMeeVAKJnCIuFyUrbaPQqlxQdyEp
         /Ti9c85y3f2iJqCKzACg0Vw1uan+1Mr9b53+7pt5NrpHz51BSpioOJJQjw9dLHKPIgbT
         MeDw==
X-Gm-Message-State: AOJu0YwZFrmjdZ9nC9OudxNyOBywh94mjHj75Boq/mKO6KxFognykRoC
	bH0+aZmZfMoFqM1UfpAyVEwlJUBciv3O4s5s5VYGXhHj608Ajc94ZtSklw==
X-Google-Smtp-Source: AGHT+IEmnQsxqbhL+kc54bSV2L83+GmG+Fg7gblHPxRC6u4UKwG25A13MYZJkaC1r992HHfS1ykOzA==
X-Received: by 2002:a17:902:b202:b0:1fb:5808:73c9 with SMTP id d9443c01a7336-1fbb6d59c0cmr20603955ad.33.1720546715244;
        Tue, 09 Jul 2024 10:38:35 -0700 (PDT)
Received: from archlinux ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a24eeesm18904975ad.65.2024.07.09.10.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:38:34 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:38:29 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Driver for AMS AS7341
Message-ID: <hix5scxn4hdii2b2nlaxha4ao73frko6ndzpbuyvhwcl2hveaa@o7zzkkk2fkk3>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am currently developing a driver for the AMS AS7341 spectral color
sensor [1], which provides readings for 8 color channels.

In reviewing the IIO channel specifications, I've noticed modifiers are
specified for red, green, and blue light intensities only.

Is it ok to provide an extended ABI for this sensor or expand the
existing ABI would be more suitable? What would be the best approach in
this situation?

[1] Datasheet: https://look.ams-osram.com/m/24266a3e584de4db/original/AS7341-DS000504.pdf

Best regards,

Gustavo

