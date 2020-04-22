Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838341B39C4
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVIO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgDVIOZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 04:14:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983CC03C1A6;
        Wed, 22 Apr 2020 01:14:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so4280766wme.1;
        Wed, 22 Apr 2020 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gcZwmzpZRozVbeeueq/lfLKF1YE2Wt6O6Z8WN9igdl4=;
        b=mQsa+QXeSYNo2dTVR3JqEP4N3d8jiSjSTcaw4vL+TujGAXv74FP5C/J44fhBnCd0Tt
         vY+mfGIHID7KJ59EQ/gQxCJsOz9hSShh2s3dHxK8YBOYxkB5hqMrTwaOcJ7ZZnJK42QM
         32s929B8ZZtK10UeINRuaHSsOJT+QbsnOZrZxW1WZaY0A/KKL1D9Wks59qP7X2PR7fyL
         Fo0p3TE1dT8NP5bVAh12KRUf95y47XjPoAxjHumxfbvnGdEZ0aKg1SCVHeiL+atXU3o1
         SR65CgmfMFiW7so27tKhEkHZeeDZIQal8T2h8RJ78NiFe8Ns4jbxHldQkLSr1aHmO5hf
         hQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gcZwmzpZRozVbeeueq/lfLKF1YE2Wt6O6Z8WN9igdl4=;
        b=ms/ssngyyS1SV/TlnCmHO+5lEWx6D5dKC2lwbMGcI/3Ok6iMZZNth6vW1AgWu/Apxs
         zMtIB3TOsSxP7ZAnsbfvdJ3xS1JfYPMxEffF9rlRTMwMldv36VoHnWe1a3bA0bSdIzzA
         EuczIuZbK/K+OJjVqJDiKFYellCIZDLNZQqwkZ4pLxO5fFpW3fDUHEPTF2IlO7ecwvqH
         qKj/fxoh0/gKxFO5HVHH6CgEUFWFbwwKkGzwd4lR6N0I1yI+6mXJ4qfFBor8zkQYjzF8
         i6qqJDmJr/4bCh/x/kiwRe0JQ+rZ2bCnvxhrUK3JfXNQIU0MG0Hfn+OFBCzSECXucu9Y
         yJyQ==
X-Gm-Message-State: AGi0PuZ1FaujBGdJE3Xk5Us8ISqAhUgwof+nbrAbGD8RsR5Z4K6jfzy3
        AJilj3/lLgK8wDJRHi/EY2+8g6QLel0=
X-Google-Smtp-Source: APiQypIFeRvLPBvGOlE2vs2gyjN93pw7CkcVxnQtwefOITVt+0IY5bCY3jraVTYx9xUOe18V7AOGgw==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr8919770wmc.142.1587543263394;
        Wed, 22 Apr 2020 01:14:23 -0700 (PDT)
Received: from meru ([2a01:cb18:832e:5f00:1d35:d245:4470:8434])
        by smtp.gmail.com with ESMTPSA id z8sm7319302wrr.40.2020.04.22.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:14:22 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] iio: vcnl4000: Add buffer support for VCNL4010/20.
References: <20200421075532.19192-1-m.othacehe@gmail.com>
        <20200421075532.19192-5-m.othacehe@gmail.com>
        <CAHp75VfXBgQad1oCBe+oqcC_oRa-3q8OBYcAOV8WfCo7n1wXWw@mail.gmail.com>
Date:   Wed, 22 Apr 2020 10:14:21 +0200
In-Reply-To: <CAHp75VfXBgQad1oCBe+oqcC_oRa-3q8OBYcAOV8WfCo7n1wXWw@mail.gmail.com>
        (Andy Shevchenko's message of "Tue, 21 Apr 2020 15:27:14 +0300")
Message-ID: <87tv1cos2q.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>> +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
>> +{
>> +       struct vcnl4000_data *data = iio_priv(indio_dev);
>> +       int ret, ret_disable;
>> +
>> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
>> +       if (ret < 0)
>> +               goto end;
>> +
>> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
>> +
>> +end:
>
>> +       ret_disable = iio_triggered_buffer_predisable(indio_dev);
>> +       if (ret == 0)
>> +               ret = ret_disable;
>
> What is this?
>
> Can't you rather call IIO API first, and then try to handle the rest?

Well, iio_triggered_buffer_predisable will call free_irq which requires
that the interruption source is disabled, hence this strange pattern.

However, this may be some misunderstanding from me, but I noticed
something strange here. In a configuration with one CPU and
CONFIG_PREEMPT disabled, I have kernel lockups when disabling the
buffer.

This is because free_irq calls synchronize_irq that will wait for any
IRQ handler to be over. If the kthread handling the interruption is
still running, it has no chances to terminate, and synchronize_irq waits
forever. So maybe I'm missing something.

Anyway, I'll send a v5 addressing your remarks.

Thanks,

Mathieu
