Return-Path: <linux-iio+bounces-28075-lists+linux-iio=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-iio@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFgrHaXKb2mgMQAAu9opvQ
	(envelope-from <linux-iio+bounces-28075-lists+linux-iio=lfdr.de@vger.kernel.org>)
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 19:34:13 +0100
X-Original-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 054514987C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94E0A968F8B
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F6478E22;
	Tue, 20 Jan 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbUXbENY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AE330667
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924809; cv=pass; b=podYq5NxcN/zf/SulhYpAy9e7FTR/+FkxW9LiahxXs/4GochKRpCQTMvlzshyDEj6+oM+QEAT4Xhwo7O9JQGiIFio8Y2OYXZdXzDnscdh+Nu4VLyECqMdr4nXTBeGpfD522PALv/YX8j1o9RB6vBTCiJo97JujMr0lTwz7V5sUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924809; c=relaxed/simple;
	bh=mZg+gNuLGUMmm9reS200ct6di3TmGNaL67a8yhNOqHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OItE6hN9bqP314leetpPJGwYwxU10OdJO6i2koQKyO7iRB8ReIaB3xn3gLmQww3dvjCHQBVpkv8fKq9PmXtpRA7CYr2yqQvOJAeOZ2GHzycELGS1DRFrcWXp/xkBXQJdvFcgxhSFyUuT7v8++xkZUoUmpTM0xsuOZc9o326J4VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbUXbENY; arc=pass smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b870cbd1e52so798597166b.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 08:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768924803; cv=none;
        d=google.com; s=arc-20240605;
        b=MD6F/XDNPxM+D9NBl3SSu8OhQLiLN+UteFW2QVpxxIwcXVP0XqgdPLAVpZOslE+U1p
         3VmdUXp4KCIoWFChmDpE6SDkq+rcHvoGi2W4lMjpM2f7UVxATkLHUh2IrE9zDhDrnk7+
         u806o1tGaEuO8coYu4HhtDKKxeB/YcMtS5WbMUG0vFHDNNIVJLPwFr202NCaWNJaMngH
         318PqxlGoL8L/fVJe8Ueeqe5ZrC3+9aZoS3SG5cnzmY4eSFUkUiq1qyL61V8zONksi+R
         i4ZZY9rdE2uvYM7g6aEUwPr1wZPQE+SieY3OsXigMHIiqJJUpIZSPjiahrlDvyfTkAQI
         YNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tBx2T+A67m01PgyNGbivaPMP/h61AlGzZA22srZv3UE=;
        fh=Nso6byM4AhWVF5qd7NKyyKEgtqeFXApyxab598nDv7M=;
        b=a+bGmPtJbXUzrpCPYeBR+/bZuy+ph/yVOTFMu6xTAqsOBmPywKxOPr6vdQxr++etXf
         SyC6DVkSKrL2AWLDzB640POdZhxs2KGsT/0wlXua/+o5ZMnUX7R/l5CJIQhiIkDp5Xt6
         kmLF9mUSdbetnu8ipc2kI1gzJn3MUz/JwBa5bCiKFRxksw5+1NXR0iUpDeYzl26D/tkw
         0tgZvf0Zg12gVoT5Qsnuz/27F+KMDIaC9RXgUV6qY2LTNBaMQWaybVNO/HUaFZRlTI0B
         aDm27dCaJa2yo6q1iyV0FvMD10lQlBhUEsh/tO0aamPdEd8o+pWVgkRwLleBniHfcD6R
         9FuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924803; x=1769529603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tBx2T+A67m01PgyNGbivaPMP/h61AlGzZA22srZv3UE=;
        b=QbUXbENYoYYhoMB20Wn0NXZxPmE336zYze4bncA+jPqzWthkXjJLTgpLuBrp3PWqJ0
         Nede143hovGm8mVHmvkRmFwF53zgtbZlPhZ0lnoheMBAzQ0RRByyKQWvgmqUmWq0p3H9
         kTRJNE1L2TlNxA4IxPbMfxFbCqGxrhFInu5syxD3TH5TL1aVV3S6Z72BwclsZZiLXwuK
         QgVZ512V+AVqseJv50sX30VjqFfBZ7rP8yGNig0eBBhb7E8BQe8Bgkf/7VVK1pdFBKBO
         YiiXveWzzD9MsaMYgHncMbm/vdTlZAUkXxeUW4JrY7fGnbxCpNOm9uQZr5kdMhb7mS5V
         sTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924803; x=1769529603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBx2T+A67m01PgyNGbivaPMP/h61AlGzZA22srZv3UE=;
        b=Ew+nVEgzPAzYfvzlEL8nP6QtLVm4d2VIvidseCH/IOemstQB7XY/U5T5McDzHjBWuP
         kRD4gUOPgW5nI2XXaaSur4l09VIWCs1/vIKZInOJKW7aC8yRzlIsDmf9YLTk+pI85/sR
         ucR38uhVmTr+AtsKDMCbaky1SyrPkRCDS1N8a8SboOdFXwqn9lnHwHkOSHcn8jNG8QLq
         +RcFcRN0tAktkIKc03SHZzhzc0T85It1t69NRYh2DclaC+bjWhX4UFty/m/ZDXuDFTm/
         J5Pb7Umw+lWUGPyD+OICbPM5RStwksgB+yKh+bokbWHFtrw5CYakLRrjOeY76Gd0tDGs
         GYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUGImEzK3e4/czRQqobei3Gte4A9UWNHV/GLXkBwq8WWgrZDlLEKOkT3UjKR0NBt9tdzmoVH28VTxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAsnYWg1ZfIbAFZrwAAgvdVwG5OcmpzlmvsFrL1DpoDLQHOBo
	7eBMxph7NqNssIRw8+Oy33wn0zj9mOoUEmSsinX0kkOxcLX1NI3yV8Manxbqh4KiYx0csF/mqe2
	fRX/I/pSG8bdvRMwrew8erhpkMG6vTfc=
X-Gm-Gg: AZuq6aLqDBGbsE1xVELGWctxY9P3ifpGAQM+HVe7zYQfbUqWMX04rbuBOCP5JoBoOWz
	LqK888bRV4e/nU/ziQqE0/SOmNgB7xC0WwrulxDM8ARxbCmrV92LVJ4tTjVX7DeJEXQC3w95zCC
	X9HCF4XDy0jAX6u/k0ERv/fy4kxdZbc7T2qkKxasBqZ4cO8gwvpDWdE0J2CrmlM+rHWrkTiet7i
	L6bCqnVJAH5U5oesHL8vH+nKdMQlz4/kw2rqxocMq6NE2+B+qjdsEezgEd5LWIotKmG8Tc=
X-Received: by 2002:a17:907:fd17:b0:b87:bb45:bd58 with SMTP id
 a640c23a62f3a-b88002927b8mr239420166b.24.1768924802451; Tue, 20 Jan 2026
 08:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com> <aWioYpYPAPOGmnHD@smile.fi.intel.com>
 <CAHc1_P6Cv3fAKjSnPKgagi8t1R1RHsavSHGns3veXNynoTghLw@mail.gmail.com> <aW5_I7KuiVGg0v_O@smile.fi.intel.com>
In-Reply-To: <aW5_I7KuiVGg0v_O@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Tue, 20 Jan 2026 21:29:50 +0530
X-Gm-Features: AZwV_QijrFKdWMIrlND2vQA6AlWU63G_coNsuBi1ar4UlNkJ7PRN3B90Vu_qkqE
Message-ID: <CAHc1_P5fnWYw4i2kBdAg1MtChD673g3j_mL+=Mg70ptLpeaCjw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: proximity: rfd77402: Add interrupt handling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,linuxfoundation.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-28075-lists,linux-iio=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raskarshree97@gmail.com,linux-iio@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-iio];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 054514987C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > > > +     i2c_set_clientdata(client, indio_dev);
> > >
> > > Is it used?
> > Yes, it is used in rfd77402_init().
>
> Can it be passed directly?
>
> In other words, can we refactor code to get rid of the i2c_set_clientdata() and
> respective getter calls?
Yes, I can pass struct rfd77402_data *data as an argument to rfd77402_init() and
then I can avoid the i2c_set_clientdata() and respective getter calls.
But for that I
also need to update the rfd77402_resume() as below:

static int rfd77402_resume(struct device *dev)
{
    struct iio_dev *indio_dev = dev_get_drvdata(dev);
    struct rfd77402_data *data = iio_priv(indio_dev);

    return rfd77402_init(data);
}

Let me know your feedback on it.

Regards,
Shrikant

