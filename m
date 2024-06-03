Return-Path: <linux-iio+bounces-5721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D18FA631
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 01:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A7F2845F9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61337129E66;
	Mon,  3 Jun 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvMt/y5l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99082D9C;
	Mon,  3 Jun 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455824; cv=none; b=KeCgb51OUE12CYw10fPHWTEVxSQ8jMo0lRouV/MalA4LCBT1bXHFR+zkxmGcWEBGNQNp3H3bdiD/1XBTpC1tglD5bIzjxfvNkn4/xrjXj9IcvYXHCbPGlpnhfuFkardQCDIVtizwjB7+msLNDuAQjkjEEJhEw3BkN7LyeH18Vcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455824; c=relaxed/simple;
	bh=UObvUUD7S0bdU5KDL/pK+9wG8ovgnlH8dQlTCiKzLK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mfo79Q1VDXOqn9YfBwpioo2VLYXhpZBlwJArs3Im9SR24zC8Zdzq/wc4G7bx8MtCjpxEQKAaZWjxlMxSKf3ZNcRSBqwS/1C1EAK0nMPuhCNEn44slQo8Mm9ezBIJo0G72Lrrxgje6vbthfNw6cNqBWNjpc9mv912wmnfspz44yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvMt/y5l; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so413245a12.3;
        Mon, 03 Jun 2024 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717455821; x=1718060621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33D9z0mFV2SIl05CRtilVSiIXuZTz3GCorDbEV0ND0c=;
        b=OvMt/y5lzFXPK3hic+CVjaiqXOrLCWGweAA3L3DMp6IVWNLyTf69S+jLFQ6SkrJR95
         TtpGw4KkZI0fDqKhpanyWtjU3rR6ko5zAgaBxfTG98+oPmfUO2y83v2Rv46QxUnB+fEe
         h9P/DrWFUFb7EHb0A+IldENVTydSTxtXeO4fQTVI1vc2SmJl5i9lDKgkAECYW9EXROdL
         sp6Bq7IoidYDQDpcYe6d4RQiZF5B5dJLX8OTlQ6V4Jwu00y2nOoOsdkyZmPCNA38Je3F
         F6TqBO3KLez93ItaHtNJQvDIuXA2mjPzVkYu+ZVhyDqXulzML50GB0uc31xWy0fvIMrv
         bvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717455821; x=1718060621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33D9z0mFV2SIl05CRtilVSiIXuZTz3GCorDbEV0ND0c=;
        b=M8CwlE8mm7ZmRxwAD2leWD+K58St3ThZ/CbZxD6uoo6mRj/daPjd+c9vgmoqB2Vjzh
         sR0yIqmP8X1XV82ka7XPbNh/eC8uX9VgWvXy24GfOz3lKi9o8m1zPs6jT2h7IWgQe8Ma
         wKatMDbP25XJNp9IDtnE3i20jlN2nIy6zpBpvgm9UicPmaTwDjK1Euc6ZVBz7BX8CHse
         UvaINbeuLSwbKrzlA5HaXyJ4PkoquIJAetSyUDHg7jhvfVwGqGcfyeJhxK4S/BKEn3Zm
         G3lsuMr9BiSGEYcEJmlitOAZb+entJo//h0Ypc91IImu1RXAujCKMqtFfsKymkoAhJ6A
         LfYg==
X-Forwarded-Encrypted: i=1; AJvYcCUGSOdlyix+aLFWDU8cVxwgdhyCCq1HnznMniCg8U0bR3pVqbzQGoVPpihfjZnyn3yPajzfEWrTTfnvcic/l1k7YilSjhPy6VQ1pF1GgGMxYZBsvog+NHWGTs7EgeZgrmFfvugHSA4+
X-Gm-Message-State: AOJu0Ywf5L31rsAoqYzouVEZbaaLJ/gh0yMnW1jJZJO3EKxPiaCZgd4a
	QbozqHCMCw4oq6hJV1obIErkf/2huXc8+YvX0ZjwZAC60ZqBB5UeDY1UsbLMX0y4Wleg
X-Google-Smtp-Source: AGHT+IEUc++stlF9fBA63Z1XOyByOWc69nuQPimjApPZTMIBmRvw9+5VUPBsJlAjY0KcxSAEZix4qA==
X-Received: by 2002:a50:9fe1:0:b0:57a:2fd7:c2d1 with SMTP id 4fb4d7f45d1cf-57a365724d6mr5518379a12.40.1717455820674;
        Mon, 03 Jun 2024 16:03:40 -0700 (PDT)
Received: from localhost.localdomain ([37.161.106.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b98e0csm6086718a12.13.2024.06.03.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 16:03:40 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
X-Google-Original-From: Antoni Pokusinski <apokusinski@o2.pl>
To: jic23@kernel.org
Cc: apokusinski01@gmail.com,
	apokusinski@o2.pl,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: si7020: add heater support
Date: Tue,  4 Jun 2024 01:03:23 +0200
Message-Id: <20240603230323.135181-1-apokusinski@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240601132507.316f9b50@jic23-huawei>
References: <20240601132507.316f9b50@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, thanks for the review. I have a one question though:

>> @@ -134,6 +259,10 @@ static int si7020_probe(struct i2c_client *client)
>>  	indio_dev->channels = si7020_channels;
>>  	indio_dev->num_channels = ARRAY_SIZE(si7020_channels);
>>  
>> +	/* Default register values */
>> +	data->user_reg = 0x3A;

>Can you build that up from fields with names?
>I don't like a magic value where I have no idea what some of the bits are.

In the datasheet it's said that all the bits that are set by default in
the `user_reg` are "reserved" and have no meaning for now. So perhaps
mentioning this in a simple comment would be sufficient here?

