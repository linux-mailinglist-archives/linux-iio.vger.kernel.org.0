Return-Path: <linux-iio+bounces-19357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191EAB0FCA
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9836A9E3A6F
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5412750ED;
	Fri,  9 May 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y96X7m0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7D222576
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784917; cv=none; b=S4ud/zGGl/84tN+SLMPPlmyePCN8MKC8LoNQPzDNOPNfV14lDzxXuXsTfTuHhBYNznHcSFu2/+dBuQ71yziWnufN8pWmLpDJHTKFRDZt9meQGmUvKsgGxG7bJwZI6NYBLJsb5e4FC9dx5Hfmw8mY8anyInyVKtRYIsPLUcUFpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784917; c=relaxed/simple;
	bh=G7jLpcaPDcD7UEV1n3Y8tUj8bdaSfnhqwEjbR49dKAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+v7C+oW+GX1lZpseLqFC7iwjpazHxQBIrseP7hJlcMYfTmhYjkGgllK2BwqOVjm333Atsw1ltxgo7s5582q5yGWAaPuKvJxkCI8mYbWCMv7GuEZVj3RTWL9aCWusVc/UVZ/HKstjTdFK7DyK0oOYBqh7ReTO0M4/Iiya7X0E6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y96X7m0f; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b308856fso1285478f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746784914; x=1747389714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=INfgQ0M3E8oLsghATJHXnHLLJnHmOLkOWbNbvDT20u8=;
        b=y96X7m0fa0K5fFA/73N205FnHsRV0qbFu71Jqw7+EDESIRlEc2uKXGFUr+ZdErnCA6
         gNZMsfVFz5htAzbPERlf5gWKQ2rx7UDNh5nUbz1Wvrb+ktFWAaqldLT3TXPxgmLSELW0
         7qxdEnN4/iMXePfjUuknMZt7+s1eA9P0bJDXBN7S8MumCsJXAswKMGml4dCBN+qvA3FP
         XHKGke3vIYrXPsXQkEEotHxKxoEQRBw2PCaTfiN3YlFdX00ieMBXGBYSCnAapJgjnxh6
         f+J+wNffV3fwOnFCmwO9sLD5KcN9znuaEvzGyRbo9jKEhq0SHbtMuZOAtYtaP1txh2Oz
         7zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746784914; x=1747389714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INfgQ0M3E8oLsghATJHXnHLLJnHmOLkOWbNbvDT20u8=;
        b=sDzJY0YYAq+QdkPJWD1PX4EOgxBCTJs2Vjcex1ilPho2mwaDz3zlMV9JMBZeaXhMC8
         21/xDNHreXmezbtCJOahVDBBtl3RI+Xms+Z186BS7+c5eyLzlsxvCklo1MjmVPKIuGhG
         pLJ5Q6x57wU3iGiucjT/v0G45VL+xC44QyUPFDbdrO/34ry56Bqp3pCxQTnhQ27aBVQ+
         aS6f9UUMAio44SzM33zJYE8g1TnYkVN/7/HwbE01ULDhZKZc/f75bYbNZ4gZMcv4CuOy
         /PTiY3JTTfwb3KyfqHqAcNcMhFsYmfpIRsQEoD9ojfSFXfz+BDyvmmFS6LZKfJpVsX59
         cHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3JA4u2TVkaG1aPZOhQW+8WqNADOyvtYGPSgBBBHjrOI6JGpYjhMXL3aTyN295jZ4rMNnL0SQycNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaEW1QXze8W7h7cIbgbQ8mca7tg3U1MpLSko7qZrqV1Wvwfvq
	jgfSbL1eNRXXnaVJf5VhX99NnRrvrSy7Jgbtk6yb/zqWZvR5On8zVIvOdfXwjiFFT7KZsLjUnCt
	g
X-Gm-Gg: ASbGncvICsliqUsILUm7+qeV4CK18QxSj5lk+EZanG/JAk4BCv9YaEQqZyozexzgomb
	b1SgmbhwPPElYlUacXsiqLaAh52WzV+crAiyg6pB4cnYVGeWdNFZHkNeEEsWZ+DtWqV00hGxmuB
	NNWmOXkMoBEBtky2YvxGXuIBpmmorGxJ/2wUl2yv0+DhW7JWyMItEPMny6VagSX868Vm/Ti5i0V
	OnHA2TyqqzzVOXuQoetrMoZORkt4FmSblKKnuX391Bjo+NLrXt4nXbZzG+iRbjioDVyXsasRs3D
	6L82ZbJLXztCKTdEo44glJbiEwZsQ6SP/S9bzOuAwqr6RA==
X-Google-Smtp-Source: AGHT+IHn+PRIpmdxojPNYUV37MNAnvxRK6U1AUgN3N8kijhOKVgW7yKp0QJe96jbi4QkSwKZrshewg==
X-Received: by 2002:a5d:5f51:0:b0:3a0:83b1:b3c1 with SMTP id ffacd0b85a97d-3a1f6432c26mr2473638f8f.15.1746784913645;
        Fri, 09 May 2025 03:01:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f57dddebsm2733159f8f.3.2025.05.09.03.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 03:01:53 -0700 (PDT)
Date: Fri, 9 May 2025 13:01:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
Message-ID: <aB3SjWjBVzuhZDJa@stanley.mountain>
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
 <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
 <aBpWXB8c8RSjYBtD@stanley.mountain>
 <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>
 <aBsOqAI0efLHGbeA@stanley.mountain>
 <b85aa946-aa5f-40aa-8d22-19a9d916f5a0@baylibre.com>
 <aB2Xam2JQ_eU9Bat@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB2Xam2JQ_eU9Bat@stanley.mountain>

No, I looked at test code from Noah Pendleton it has a mistake.  He's
testing assignments, not initialization.  It's a different thing.

I also looked up the relevant portion from the C11 standard (6.7.9)

  — if it is an aggregate, every member is initialized (recursively)
    according to these rules, and any padding is initialized to zero
    bits;

Which sounds like padding is always zeroed, but the context of this
quote is that we didn't fully set every struct member.  We drop
support for compiler that are over 10 years old so C11 covers
everything we support.

Here is the test code that Noah was using.

https://github.com/memfault/interrupt/blob/master/example/c-struct-padding-initialization/example.c

	struct foo foo;

	// 3. use { 0 } zero-initializer
	memset(&foo, 0xa5, sizeof(foo));
	foo = (struct foo){0};

There isn't an initializer on the foo struct.  Then he does a memset()
and assigns a struct to foo.  Assigning one struct to the other is a
different section of the C standard.

I created my own test:

struct foo {
	unsigned int i;
	unsigned char b;
	// 3 bytes of padding inserted here, UNLESS -fpack-struct is used!
};

static void print_struct(void *buffer, int size)
{
	unsigned char *p = buffer;
	int i;

	for (i = 0; i < sizeof(struct foo); i++) {
		printf("0x%x ", p[i]);
	}
	printf("\n");
}

int main(int argc, char *argv[])
{
	struct foo one = { 0, 0 };
	struct foo two = { 0 };
	struct foo three = { };

	print_struct(&one, sizeof(struct foo));
	print_struct(&two, sizeof(struct foo));
	print_struct(&three, sizeof(struct foo));

	return 0;
}

GCC does not initialize "one" because it's fully defined.  Clang does
initialize it (because Clang goes above and beyond for security).  The
rest are zeroed as expected.

regards,
dan carpenter

