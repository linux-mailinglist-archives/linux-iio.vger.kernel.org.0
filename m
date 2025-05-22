Return-Path: <linux-iio+bounces-19811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A0AC13AA
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62777188B3A9
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3F1DDC1D;
	Thu, 22 May 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDX1YRMT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FF148FE6;
	Thu, 22 May 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939655; cv=none; b=R71dUHym6AUAOa9KCNtuMUkrQljGf7QwUsxFJJ1qVKsTUBlJhf1m4GlcGlxok4ozm5spsjMfA2Nu1KUzbBRFpCy/mGe6tx4JN+8vJyNCBdovW7yZ/EnMXxAYEgQiL0vhZNDu4N1YivFfTXthvk+RZy4ZUEbfKq4ovBTH1En8OII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939655; c=relaxed/simple;
	bh=q2fzgGEzEer9UKDXzQMbj1JzqjoI6qPzwxu8XOarHp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bprE7/GUK+iIZyrtvumRAzUbM9CIoYxPYznEdGQ/vnhPFSZU2s7ZdwdjDLPFBqG9OCbdj6nSZJMc6JIz31tKzIGGjq/ZZikYXL7OS7Io6HzT3PhO7lPfC5H8QxQwQjwqzYHmsYv93slQ3O0W5ql2fZ1Ah/cIlJdDx+4QZv58r5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDX1YRMT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742af848148so5020043b3a.1;
        Thu, 22 May 2025 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939653; x=1748544453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqjM7JiAJRZPAZUvs2BT2pveQDtqf6gOUjP7YYskxSY=;
        b=gDX1YRMTSId7iWlrMAkl09LTFBTmmHP6CHhGqYMOOBuHdU8e8zL2F2XHqEFmPHXMgv
         n7f9WQmDxw0g/GuhwEV0N0CRzz9rhKF3pkxxg7bWKRspirakEf6SdK4h0ek5WtPJTgIm
         ENOYJDHUj640s9L7MW1xwr8m7ZcW1jFizwO39ZktJAmtuKpl22IPqIuFZ6afWnw0GEV/
         /ixBM6SHMqQ1ZZJz7tIytCf4R6IawNibPHexXKucU3TkpJvBiAvRvVFAJmklfsEnmhO0
         EhTi/9i9VHydltGSEZpie7ArVwetcoE36deK7xBYr1aQVuLi4ohmcnKpmPaycdd1Q3+N
         fF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939653; x=1748544453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqjM7JiAJRZPAZUvs2BT2pveQDtqf6gOUjP7YYskxSY=;
        b=H0veOIt7/g6/1CiOZfPFhgtuZy7+7Ud9rn3LR9Sd7vywOj1KAFg10SDXaHfe4j0Um1
         KeF2+NQF/hIOu/K1QalpparvvWqreetNuI5TnNn1wD6s8Wi0HiD7cWPHjaqiTqUpeanb
         imzA7Rg1hAkjDlI7Hxr5FJIz8yCMIJUw6vj4MV1QyD84fW5TicLYn4A4qwtlYFU2hPyO
         PN3FdE4EwYsbsFkkDuugEo3gqLui86fPtfmm5Z/f47wIl3p+lGJpbYPRGVurjimYHIUX
         g3XoHxV5F89FmggknNsZ/hy2J8A/Fn+Lb0l0QiJdvXvDxHvCvl48YI3oWmyYbWNxOcta
         /g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGl6F3qagcjox8O48ymNXmvQcEJF0k+lbUutPsOOkfO/76UTN8wUAYZvwJbn/TpK44+YlO7EJiITSFZRQ3xTq9Ry8=@vger.kernel.org, AJvYcCWQyAoLxWju4Bzl/jjfIg5I5MoWtiDHK+eYNhbJcsgvTtvQ3ZXlXwN6hP0DT/6AQMwkZ6Gae+UjvZ73QZ2k@vger.kernel.org, AJvYcCXeIHWDWL8BdkjNwKfdi9ZeEKskq40Nsheb3VLKaaOsMP1jMNHR/Uv1y40QuaDEVFN/swg9RQa4BZM=@vger.kernel.org, AJvYcCXuXnFUt2ofV3X1tu7Pg23vSfIcjXnd0TGnl+B+OISuFJNXfz8VgHkK73PftoOYb6QimDa7QQbH+9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7luzsgkbgbFdTjBuV6xAfoSUh1QfvmIFVhesUzwLQK8yNY4I
	QhQaurE3UtmRlQG6Tga3d8L4HQd8yMwt1F6yUOR/hRUiEfnabRrs6kM/
X-Gm-Gg: ASbGncvKmqdJqvnAIBiiY3m3RDA6Biba0SvURpZsW5ccG6wc77h9O1kYv8xYK7+h0sf
	/PGbcKjMXgGakd+2slBqByZjbRDi5lZFhMK9T+UgXposqycoy9UonVN5DvNpAyzjq7Z4lchJUxu
	0EnzFDZPK3uO7LNRBWocNMJWsqmW34DwqPoe0glMgaGKRlKd21pIiUbS3x+Y4bHF4dAvWAJiF6I
	ktrKXFF85lfqXIj+LR0prepZ29RgjwXnf4zd53Nzmj9pr58ySmYgDhHXlsAr4WGIgGBAaKZ9uk7
	bvAz35fYH/hnd0CGTCU08zYNkrUtrQIYqQdtrTDpXFiqE+1gTDXi
X-Google-Smtp-Source: AGHT+IEKsW/sM3XvtW0NVqb+2HggX17x+LZ2qZZE2qlmNiOduK3AHdv8bc02Dke14mfCYtW0f9g74Q==
X-Received: by 2002:aa7:88cc:0:b0:736:34ca:dee2 with SMTP id d2e1a72fcca58-745ed847e68mr258205b3a.4.1747939653145;
        Thu, 22 May 2025 11:47:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8e84:1516:ef48:7c66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829c7asm11612992b3a.85.2025.05.22.11.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:47:32 -0700 (PDT)
Date: Thu, 22 May 2025 11:47:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
References: <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
 <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev>
 <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
 <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev>
 <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>

On Thu, May 22, 2025 at 06:28:44PM +0200, Ulf Hansson wrote:
> On Thu, 22 May 2025 at 16:08, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >
> > Hi, Ulf,
> >
> > On 22.05.2025 14:53, Ulf Hansson wrote:
> > >
> > > That said, I think adding a devm_pm_domain_attach() interface would
> > > make perfect sense. Then we can try to replace
> > > dev_pm_domain_attach|detach() in bus level code, with just a call to
> > > devm_pm_domain_attach(). In this way, we should preserve the
> > > expectation for drivers around devres for PM domains. Even if it would
> > > change the behaviour for some drivers, it still sounds like the
> > > correct thing to do in my opinion.
> >
> > This looks good to me, as well. I did prototype it on my side and tested on
> > all my failure cases and it works.
> 
> That's great! I am happy to help review, if/when you decide to post it.

So you are saying you'd be OK with essentially the following (with
devm_pm_domain_attach() actually being elsewhere in a real patch and not
necessarily mimicked by devm_add_action_or_reset()):

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index cfccf3ff36e7..1e017bfa5caf 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1376,6 +1376,27 @@ static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env
 	return 0;
 }
 
+
+static void platform_pm_domain_detach(void *d)
+{
+	dev_pm_domain_detach(d, true);
+}
+
+static int devm_pm_domain_attach(struct device *dev)
+{
+	int error;
+
+	error = dev_pm_domain_attach(dev, true);
+	if (error)
+		return error;
+
+	error = devm_add_action_or_reset(dev, platform_pm_domain_detach, dev);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 static int platform_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
@@ -1396,15 +1417,12 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = devm_pm_domain_attach(_dev);
 	if (ret)
 		goto out;
 
-	if (drv->probe) {
+	if (drv->probe)
 		ret = drv->probe(dev);
-		if (ret)
-			dev_pm_domain_detach(_dev, true);
-	}
 
 out:
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -1422,7 +1440,6 @@ static void platform_remove(struct device *_dev)
 
 	if (drv->remove)
 		drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
 }
 
 static void platform_shutdown(struct device *_dev)


If so, then OK, it will work for me as well. This achieves the
same behavior as with using devres group. The only difference is that if
we ever need to extend the platform bus to acquire/release more
resources they will also have to use devm API and not the regular one.

Thanks.

-- 
Dmitry

