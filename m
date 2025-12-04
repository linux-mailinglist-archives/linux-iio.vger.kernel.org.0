Return-Path: <linux-iio+bounces-26761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D999CA4CBD
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DEBC301E214
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C035F8D7;
	Thu,  4 Dec 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJVXTsHi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238A35F8CF
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870433; cv=none; b=N1Jt+c4Z7v8FjN52jRbiLl8lENTBhLJJFBSe53rDMfVhuO78ql4lipobucfTyNekS+sHuKeA/vexEVCU7dBaMtEx35cEaPH2xVzt8xHW7dFFoJodhybPQ0pPWlxUEUKPOLr1Vs6uQRKEbNScKYOevI4c6sAICl+CqKbl1pA5E7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870433; c=relaxed/simple;
	bh=j5ce4MuyBvQjrpJELeEil3FKt7d/yeDPVp6ZsfzCR7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MwPRBJZjpz5Yo2glyPtUCkx5jWs2C/P2h/Kx32SHZ4abGufO56bD2vsOKwUFEqc30eccMCU7q/gBbmDHCUyNUE6blQrHo2rhIcGhL9K2KGrlll2h76SlmcIisac3HdEsC7PegI3i8Tt1iRO/Ec6H+BroCdfO3re8F4q0FbhEwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJVXTsHi; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso1002407137.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764870431; x=1765475231; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxTuuhC6K5r77VKAabl7de61jARiW/6sGzO1IjQmqtg=;
        b=bJVXTsHi/EHy0+V5kKy6xNMIACj7g+RoBBtzQWFzz46fJChZHcAaCMwbhSRy+K4+Vm
         HhXvvBpzmacuLi3MKpNlXKzQn3ReIokiF09CHDPRDzXSDRLyU9Al8ebFCQX+giYJNQiw
         aLkS3B0HDV7aJast+TNCxk2xn5jJ5VE4Bc2xKriU2ORdhy8MxjmfggK2tZ5eIn8Ft3uE
         IDWK1Y+QSF7L++Jqdl8VmvG//fTJ0KVStufQrCXI+t1uw/8ojm07oxJ+cm8tIBw04ODw
         v1GiwVxUSO1insG3+WXe9Ymm8zailYLRr6ZMMQNoCOAtafX8ArF6ef1lRWhkctWFOba1
         vNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870431; x=1765475231;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxTuuhC6K5r77VKAabl7de61jARiW/6sGzO1IjQmqtg=;
        b=RdDQYZJwKzJELl7sIyC3+sPuJtSulpfUGwZgp3HDyTljs+mco0rz3IeBey2EC9x5dK
         24LHdH8eaaI6hN8hkduRPzWVLneodXMrls+e5oMcgewKXVdK41DH9D71f1jfJs1j2XYl
         Q7f8U7DgENQW85KnU/lNQ+BqcvDSy0W8irIgweqzthVJy7kEZlqrP2u3FVV0zoCW0oWw
         XdBJhD1jvLB20SQgFCr1QIGocT+tLy+Jx583BurKbdIVqLFhPG0ACa+2uab2UE2UV50d
         87Cu+66mZ/9zwKW6SijC95VLurs6tJHLO1NXz1d6w1W1lTqx4c+kwqqQ9ntGPIzc760R
         2uIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt+YO/Hb7CRJ+k3+Miz3y1miF3LeWh4CNym67MrjUEEs6emlh4fNLfxfZxf4Ato2QwM2aKLj8rIk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9B6JTdRpgYUyRShiJfzQ7+MuzHM/+YgxEzuS4U7QHwO4/IYX
	oZ0N1EX1XdK+QTkiuHaPNgxmUzunkEz8VtlR8D8ZW/aByLkpysK0LydN
X-Gm-Gg: ASbGncvx5FxArCFEFO3Za30LYmpIQANBrwHnvh2lxP0uXr9dp7IdD/dZo3fZ3TjZAJ6
	ilBK409HQ62olNsIp/wmEI2wPhQAHCcAWYJMZ03W7yOaPp0TYwQgd8Vh5/KW4MapzbSQLrhZB5d
	jhS+ts1uC3hs6cwS1BZtpVHxLnz83m1KKZNX9cbuFY+h8YEkt2kHZ6z8xKjAPLuJaBeWr83DLvc
	EllEc8ZQ6dtfAnzudi/24S6YXCnhtzIYWNM8WtafoWBGOggyCW+hw6QXL8aHeTK1D4ovt10HaCw
	QRpMQyhKFOf/RqGdeAkDtNukxPWQ6ILZKxk1vS2m5qdRS4+QJGuQ4vPFbchcL1DN4q3pARAapgw
	jnoeuICk3ZJEsmWMM/4nimuky5kOXX37LP1Yo1K5InZL4JCJrY6oqnY1auLE2K1ghq9t/vO1cT+
	n9OEPQBwiuYAPREPxL
X-Google-Smtp-Source: AGHT+IGXScj2mOQRJ9yhwkdaTxAxTBw1Wgm1t0kR6AWVQduW0M5uS1qVXYn/b2A569iZ2os9zht/cg==
X-Received: by 2002:a05:6102:3706:b0:5df:abc1:e6b5 with SMTP id ada2fe7eead31-5e4f926ca67mr1992475137.17.1764870430714;
        Thu, 04 Dec 2025 09:47:10 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93eed696d96sm816691241.3.2025.12.04.09.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:47:08 -0500
Message-Id: <DEPMCPWLO4FO.2B2OXMF2CZ1G@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
 <f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>
 <DEPLIJFBZQ36.20XX5DCMCJVB3@gmail.com>
 <c9efd563-9d52-4761-a5f1-be0df0222dff@baylibre.com>
In-Reply-To: <c9efd563-9d52-4761-a5f1-be0df0222dff@baylibre.com>

On Thu Dec 4, 2025 at 12:35 PM -05, David Lechner wrote:
> On 12/4/25 11:07 AM, Kurt Borja wrote:
>> On Wed Dec 3, 2025 at 4:52 PM -05, David Lechner wrote:
>>> On 12/3/25 1:18 PM, Kurt Borja wrote:
>
> ...
>
>>> I would write the whole function like this:
>>>
>>> static int max30102_read_raw(struct iio_dev *indio_dev,
>>> 			     struct iio_chan_spec const *chan,
>>> 			     int *val, int *val2, long mask)
>>> {
>>> 	struct max30102_data *data =3D iio_priv(indio_dev);
>>> 	int ret;
>>>
>>> 	switch (mask) {
>>> 	case IIO_CHAN_INFO_RAW: {
>>> 		/*
>>> 		 * Temperature reading can only be acquired when not in
>>> 		 * shutdown; leave shutdown briefly when buffer not running
>>> 		 */
>>> 		guard(iio_device_claim)(indio_dev);
>>=20
>> AFAIK you can't guard() inside switch-case blocks. I don't know the
>> exact reason, but it has to be scoped_guard().
>
> You can. You just need the braces like I showed in my suggestion.
>
> The reason is that guard() is declaring local variables and some
> compilers like LLVM don't like declaring local variables in a
> switch case. By adding the { } scope, the variables are limited
> to that scope and the issue goes away.

Ah - You're right. I dind't see the braces.

Now it is overly complicated. In this case I see why guard() isn't
really an improvement.


--=20
 ~ Kurt


