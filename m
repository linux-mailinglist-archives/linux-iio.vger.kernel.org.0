Return-Path: <linux-iio+bounces-6306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45483909907
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E11C20E23
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742302E62C;
	Sat, 15 Jun 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vYWjgOww"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB21C6B8
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718469065; cv=none; b=RhvXcd4Eft3i/IHcZbiu7v3yyixGq13JAANYK5ll0oYLkNDyuxHcjEaCzUX+bFDWBvGBxF5tt9dqanJFALL3WHQYZ23fY9FKk7sJV/oH7cBSegAHIxbl2RmCde2oA4ynEbeodcdA1Cg8ujasO7CDWi/rhOmSQT2UqUzzrmd3wcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718469065; c=relaxed/simple;
	bh=7VZx2zIx3fKKcO70Bfua49T3IcTFqL70s9M1O/FXukI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neRqQRIhOkZk9z0Brnmo16TgLgtN44uMPumuNK/o1bL27378EqmZ397NV/RGjobKBNjUtK1uC4AfF5gUvJCjPtBstCX9KQTrotf3VSo+5li2KXeM3/30/g3Bp+9EwsoVAUB0nCYKvEnHUV/7azEue1HGW4DmAuWPaFqwUuI5ddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vYWjgOww; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9cc681ee4so1536190b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718469061; x=1719073861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeiXgqyhT/QZGQjBMNx/jn93Qfipagj532oIUhz8rF8=;
        b=vYWjgOwwzODVWhBCRn2O2nx//GtyAyTaoH+L2P+GRoVHYekObKclzsOGUJYS4z+gHb
         xYLy4QaJdQs4xjXCQGa0frex4LYhzBeZXb34jeQ8Cfe/8UdkVxz3xDUDqBkUlZcYzkyj
         xJmLlc6F2TEfIoJ7oex8TBzES0IYj5h3NwdLJLWuDys7eUM8s/0EQxn2XlbNByWwzFQK
         Zn2sd2EXo6iq3dXCR1nn/dj9ISW1kKwF1Xy9JjUZSyDrOZt7bqmVXQ6/0Xk0fSv022l7
         bbrrIT65ufKfd+xstsAa/PynqEWgUXUzYdn5mQFAssjQhzmx1sYZtjZjPiqKiegjnzM6
         KzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718469061; x=1719073861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeiXgqyhT/QZGQjBMNx/jn93Qfipagj532oIUhz8rF8=;
        b=Y/oz1UXTE0oaQNTbskinXOuA5Gfa0LtGLzAy9MCiKIyMGkEjd5+y+h8hNVYTSg5KOl
         fXvaoHkvgZDjGWTuyS0P2zS6HXPtsZfvF0e4N6lk++PsnmBeb/e9gL2GtlYMuTmgTeWG
         GxCpLAShds7dcynB1e9bPPE5viE51SIACYM0hpY4GgfbarY858h2YMVsZOMRQ0RP09Iu
         6aYBQp7xKGK4IOeaO8sn7hRrgYoK3qO74/ujsBQsWy317x9FB6KXuOeE1MaFN4n5uG7b
         h2pYCXDg8fflapqk23uZclIy0mpL/XMjUJGJJnhhf/ZdhMKhPX2eH+A3zchpMD9aQUFq
         FdUA==
X-Forwarded-Encrypted: i=1; AJvYcCXc0hhA9p/16eyvZF88HLbjjXB2ABkStbzbOvUIxKbmr4iSQjUSvRDDsXVQnGqzZjDSrgVdowv+lrb6xQkbsr5mYrwodjwPkCt2
X-Gm-Message-State: AOJu0YwDb+gr0+SELqmh71FYDdAryZAtc6SsqumXEtCnGiVSU+CQjYet
	CC4lf3/JD+pj/cA9UOyk46Rv2zD7uhOTA5MrajIAuApfhU1rBIJWAZGmH0EHZbA=
X-Google-Smtp-Source: AGHT+IH0EX0O5PGkdjvB3T+cDiqoufj+oi2S6HzWbdAJ85VUqRve1OR4y4oZmzefOYrvHpdlw+aclQ==
X-Received: by 2002:a05:6808:130c:b0:3d2:2d1d:3786 with SMTP id 5614622812f47-3d24e8ef7c7mr6367451b6e.25.1718469060952;
        Sat, 15 Jun 2024 09:31:00 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d24762eddbsm961125b6e.30.2024.06.15.09.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 09:31:00 -0700 (PDT)
Message-ID: <21aa7ed7-6440-437d-a591-0da8cce4bc00@baylibre.com>
Date: Sat, 15 Jun 2024 11:30:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-eqep: implement over/underflow events
To: William Breathitt Gray <wbg@kernel.org>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240609-counter-ti-eqep-over-under-events-v1-1-74fe1632f5ab@baylibre.com>
 <Zm08ZiyXEgWYLZbc@ishi>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Zm08ZiyXEgWYLZbc@ishi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/24 2:01 AM, William Breathitt Gray wrote:
> On Sun, Jun 09, 2024 at 04:49:33PM -0500, David Lechner wrote:
>> This adds support to the TI eQEP counter driver for subscribing to
>> overflow and underflow events using the counter chrdev interface.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> This is split out from a series that was sent a few years back [1] that
>> I never finished, so I'm calling it v2. This was tested on a BeagleBone
>> Blue using LEGO MINDSTORMS EV3 motors and this script[2].
>>
>> [1]: https://lore.kernel.org/linux-iio/20211017013343.3385923-2-david@lechnology.com/
>> [2]: https://github.com/dlech/linux-counter-ti-eqep-python/blob/3745b0840736248d8e60cc675a0f43558fcbb2af/test.py
>>
>> v2 changes:
>> * Only clear interrupts that were handled.
>> * Don't set default QPOSMAX value.
>> * Don't error when setting QPOSMAX to 0.
>> * Use regmap_write() when appropriate.
>> * Validate watch channel.
>> * Use counter_priv().
> 
> Hi David,
> 
> It's nice to see progress on this again. I remember there being some
> sort of interrupt storm if QPOSMAX was set to 0. Is that still the case,
> or was it resolved with the changes in this version?
> 
> Willia Breathitt Gray

I haven't tried it with the rest of the old series yet, but with this
patch, it is not a problem to set QPOSMAX (ceiling) to 0.



