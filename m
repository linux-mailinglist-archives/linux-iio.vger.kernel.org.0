Return-Path: <linux-iio+bounces-15812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405DA3CC26
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A2E189437C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992531EFFA4;
	Wed, 19 Feb 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibH44aeC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6114A09E
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003350; cv=none; b=YNNESt6C+vZdJVLalP3eFAhZFgQzvqsFkk0nYoGhHcFlaBpxRUHuWe8I1xDN2lNzpIZu5vekVBDQL20vDY3NPLv1W5XGpGKMuGI4DD7EDdJwXzIlKCW6UQ3ASM9hQeq4n7VSy2ZJQSGIwRmIHr2FoysTV7QbGm2iUevpKT0ZlVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003350; c=relaxed/simple;
	bh=b2YgUcsEtKdZm3lpZ/T7h7Y1gRYtdDGz1wKwQ/chLN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoqMA9kmGXh8Wc+SohDyiuIZeI0X0rH3ZvQ0/eE5Jqe+S+PP3d5l7zSRik2Ei/V6idSLvAGf/wZWNPINHrJKHPFTeBYurf8Y/EplLtr4yB+uk1GLFyRuxyoxF1SiGR5dnUMFtugQOs9HcGyB9AdwLOJON63xfxygXRundV1lpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ibH44aeC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso4158455ad.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 14:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740003348; x=1740608148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUTzFxcEo0vBZIZ3J735rVLtOIUOXWthhsxU1QIsawI=;
        b=ibH44aeCknuU9ymuSUl/6HBuL4wrNZeBDO/c81g7e1YDVXMeWXjZxHsREgCEH7TZo/
         j06xMmwUsHmIG1x42nQiAkzMidKWJplaEnpc20TRWLePOOj2DAHB/2gA48R79qQgnqq2
         fqjCfObDVcC82G1ZHDzP30/kAlP7CVL+jI0h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003348; x=1740608148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUTzFxcEo0vBZIZ3J735rVLtOIUOXWthhsxU1QIsawI=;
        b=f0mJ17wMApWjpO+YbbGA2N8FTMexGsg5a6/FwMjUg3SjBNEU/qmneyYQQYS95lWRFu
         KzKeY+QXfzvSL6P0qrU75WFtzzLJG9DCAGworS9YdxKt9sI3LYyWjXBjd8TLHwO9XgVq
         YhpguENg8CD5W6M4NN8OD/HD1ZiFPql1WnJmFIO0qkfoRTgNb+aT3FoYa0/6s1XttZ9s
         TV4+ZLkAdmcme8LshdO3BEMBgqCZNdsBcDdOS2VoAhYZMvCehwenMXz40ZnkVO+kW3oy
         khzXkpASM4RTTGTMxMo9z3EvAchCXLI5bSLnoLzVjrleglKURHQjzIixqXHSvKd8XT9Y
         O+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvyzOV9d7+SUbN6LT8ZnxvBa8Ri8tCfz/ljfJsbmTnUicTr0wtQWEUx7rnrzU4HVdRkkqfVsuEhI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nOKXFyVA5tDq0hj47+onz+ZIR2Aw/howfXJTXAqUzwPFlczC
	ZD6NkzvGvdIiV5vFQLiTxmyRRXXE1+n0Uzpjd4819hgTklsbfsF1JPCODVlp3Q==
X-Gm-Gg: ASbGncsMwIYOBCzX7dlB860yoSksWUPOcOzVhBJ5TlMS3U6LPQh/KJJ5ry9oLbG4X+R
	ntVcU+Sjvoa7L6mjKtsib2PsE7XlU0ZNZkngfFQkAEGc37FqXE/69S/GZj401T/XwV1ufhLiydl
	ehs76Pc4bq/nSGdY3UqQRkvWyjTcpMh9napCJ8WLrJL62bWKZTVlGYHAZBmt+e0FGxyZuhpv5Zx
	3UhjGagaPHi+3ZwDJsqd/TbIBSCx32irmateG2LbqIuCKFfJBiM/I99toULuzxq2C8O3sTWydU7
	5/kwelHwSuAF4Y/UOpRo+gkBxQAwIK6y67r1RFh/+WHPEqoO2a9INA==
X-Google-Smtp-Source: AGHT+IHBOzzGaQZv6nzU5gasb+yLRcfRb1LfyeNWbuAMCeAMjpDumyCKot5B+fc1Bjp5QjOJiS3Zbg==
X-Received: by 2002:a17:902:f54e:b0:212:996:3536 with SMTP id d9443c01a7336-22103efa4f4mr361188295ad.10.1740003348213;
        Wed, 19 Feb 2025 14:15:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:151d:7120:73cf:b371])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545c9bbsm107887405ad.127.2025.02.19.14.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 14:15:47 -0800 (PST)
Date: Wed, 19 Feb 2025 14:15:46 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>, Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z7ZYEp4oqPs12vsP@google.com>
References: <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
 <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>

On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> The reason why runtime_error is there is to prevent runtime PM
> callbacks from being run until something is done about the error,
> under the assumption that running them in that case may make the
> problem worse.

What makes you think it will make the problem worse? That seems like a
rather large assumption to me. What kind of things do you think go
wrong, that it requires the framework to stop any future attempts? Just
spam (e.g., logging noise, if -EIO is persistent)? Or something worse?

And OTOH, there are clearly cases where retrying would be not only
acceptable, but expected -- so giving special case to -EAGAIN and
-EBUSY, per another branch of this thread, seems wise.

I'd also note that AFAICT, there is no similar feature in system PM. If
suspend() fails, we unwind and report the error ... but still allow
future system suspend requests. resume() is even "worse" -- errors are
essentially logged and ignored.

> I'm not sure if I see a substantial difference between suspend and
> resume in that respect: If any of them fails, the state of the device
> is kind of unstable.  In particular, if resume fails and the device
> doesn't actually resume, something needs to be done about it or it
> just becomes unusable.

To me, it's about the state of the device. If suspend failed, the device
may still be active and functional -- but not power-efficient. If resume
failed, the device may be suspended and non-functional.

But anyway, I don't think I require asymmetry; I'm just more interested
in unnecessary non-functionality. (Power inefficiency is less important,
as in the worst case, we can at least save our data, reboot, and try
again.)

Brian

