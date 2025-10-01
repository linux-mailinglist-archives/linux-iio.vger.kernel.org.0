Return-Path: <linux-iio+bounces-24624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC304BB081F
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667301884014
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C605B2ED166;
	Wed,  1 Oct 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="He/8RkHT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A82EC08B
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325400; cv=none; b=HANjPSQg8CCv8PIjWEyv3LwiQMgxLpD+hSRiEgGl0aYHQi+SQwq5QJFHb8G4DWin70J7qbZCQ5O/BSg18mfEik5phwf0NQpB8Hh/DOLfttiFslvhQTA1q/OLmu4zivgQv0kfWoJ7Lk8YliSIYI7TPJvfGY1xG82YYwhkj1mp8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325400; c=relaxed/simple;
	bh=oSpYkqLXX87cqY/K0bfCZ4noKm431k61WtJ+tktIdw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAAFcazhts1KE41qVJHgLmSps4AobC9if9kvQox6QQxEQp4uLMGIPeeDYP8HaXpMwhpuqno+UTBEy27FWH3R1S53pEl3UH1fKTLR308J4DuUdaFsPtC0GLZjZj8Nm0hG0wGxl4YU1TzooOg46FBvXC4jod7YXMLcZco+wqUtVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=He/8RkHT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso5435792e87.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759325396; x=1759930196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSpYkqLXX87cqY/K0bfCZ4noKm431k61WtJ+tktIdw8=;
        b=He/8RkHTBqJ/+DfSO2zbQXiJg4xWKgYuYt4Mk8dt/aTv3uk4F31yCzyqkCjMN+y74L
         rLnYYfN7y/zUlBgrfw/wz+tmHOu0bG6+KvpWKWQpbSgmGT73LzAnT5FC2lTYhoZMs/FG
         cZ04eRh7iMC8AO7wxnvA4ID1esJyBBB3+zpNP61XB698BkE10jxRAoroup7wkupK/+co
         Z5B5RGMJA6NFyPA5aucX7mJxgNVurqreWadlyNJsttB3UiTzB+ZyTkgHV0jaQbx1ieUL
         qDMw9IF6iDVWzo1JQojGMubELDbvM1dgIeOczFS5/ZNnaDi/BgwKW+nFMiJJDGPtBHIq
         1JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325396; x=1759930196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSpYkqLXX87cqY/K0bfCZ4noKm431k61WtJ+tktIdw8=;
        b=Y0xucqNvqIelb3kUpXi7D0isFp+tFPos/IevnV/RlMpjaE14HxQcUCEBsC0m9HahAs
         FwdhpxHeEwmrOc+AzSr//8YzbJqiZeEalQPjlFnFbaqJVYzkp1MCxMJzoktW/xCDniPg
         U5oG8VBs4m1vDnlOMehVqF4HdXipdIjGZqO65OW2wsFBlTCN4keq60/cyTcbgx0fTrtK
         xWhjqyrO0zrZaVfVQ+yazFJYGU4fYUDuSeP2MC8ThDkFEZ+mv+1KnXJx29JmJL7jewDd
         jsaP8ZKVvXIemhkQ/a7mo1xfHAkTIMRc9K3Dc+8fjIpcb5YPyrTbZt/DjTmQFCSIrC2D
         KP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVtMLKYs63tktsdmCn7Q7jzjvRkXtB2VPhpKT/IqZOoJuJ9S9NrwN9vncv3ZbvcWWUW/DSxNj3cLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUyNmzpTZoy01rtJzQRp1YAlWFyLN1lvHNXeOlV91OfhEtNAr
	VOllLvY7cIY7KDOy9ymVv8ur3WYLWwQgyjaIGLPvvUc2vhkbpbwjSI50pE31XxITyRZGSIWxSmX
	TvG+JT+cQoRMvyzRoWSEVX/E8VREQEcZyL1lQQt4lzbHfxPVtvau52BcXiTOX
X-Gm-Gg: ASbGncunVGHE0vCbtC6koa1x/XgtrcalbozF7t6qwseGJFUhCC1bcfu9b7UxtKIuKfC
	GL7AmKnvyQetjh7b7UTIIYKeIttbmKQ1insQt0ASDw+YKqFO9aHH3+bVKuSftHW5WAPll8fv35D
	XbN3oquFx/IQugpUw5EpIpAD7Hf/Qn8u6k+EDc7CT3uCXgu7KejvfP53ZiC4yWp9omGr23I2R1+
	XHxEs57stTJZjmsNjk6V+sPAzphwoQ=
X-Google-Smtp-Source: AGHT+IH0TEVHM/TN6VsdqXCX7jpTjFKidGCDZ2rcSTut93tQSEm3eOecJ9+u8wxPt/VQEH8qd46DsEz9rvbHOLZ666M=
X-Received: by 2002:a05:6512:2383:b0:588:d2d5:8cfc with SMTP id
 2adb3069b0e04-58af9f5197emr904944e87.47.1759325395880; Wed, 01 Oct 2025
 06:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909085528.68966-1-andrej.v@skyrain.eu> <20250910193049.145aa79e@jic23-huawei>
 <6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu> <20250912151259.00006fd5@huawei.com>
 <b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu> <20250915165313.000041fa@huawei.com>
 <722b91bc-fce7-4e1f-811f-aea30e130f15@skyrain.eu> <e4ac030c-8ce1-4b71-9b37-a2d304defdfa@skyrain.eu>
In-Reply-To: <e4ac030c-8ce1-4b71-9b37-a2d304defdfa@skyrain.eu>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 1 Oct 2025 15:29:44 +0200
X-Gm-Features: AS18NWDsu0ZyPbHs0KO2KtMxeVKSH_7_-q2e2ZjoYeuSbcGFN4CeCi9a1ugGPNg
Message-ID: <CAMknhBFSG8B+yJNAjeFpFC+K8iRkQrWczy1FPyxsQrxxdDCudg@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Kessler Markus <markus.kessler@hilti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:24=E2=80=AFAM Andrej Valek <andrej.v@skyrain.eu> =
wrote:
>
> Hello Jonathan,
>
> Just a friendly reminder :).
>
> Is there anything blocking before going to be merged?
>

There were some changes requested already [1] to add a Fixes tag and
use a DMA-safe buffer. There is already such a buffer we can use in
struct adxl355_data..

[1]: https://lore.kernel.org/linux-iio/20250927145515.26692e60@jic23-huawei=
/

