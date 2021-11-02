Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E08442921
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 09:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKBIO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBIO3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Nov 2021 04:14:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E2C061714;
        Tue,  2 Nov 2021 01:11:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m14so20012552edd.0;
        Tue, 02 Nov 2021 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PonNbMWoqThkAKEBfztMgFnpTF3vsFT/dHecSBkyWI0=;
        b=G5eBfID8eDolsskr72EFJJyuW1FqdaP9+vW7iFdqD31D2MZcp4lLKFX0QcnO56DJfd
         gWRXDcJkJAXblAPxVXTzIhjm8cDntvdRKc94B3jSuTKA7KsAJ2ztrwZ9SBh9+cNHGNn1
         lBwyOzGVC7PBTIirSJR81c+KqYu6WNNLmES3BpuWGdYgXCSMs6RbkP3zNPLsndMbHsx0
         jtQj5tTiaWhl7hshASMOrrNvIaQwpl1sUimgNKaOxkeovwG1d3Yvzg5zVWTvwiBwZWIl
         7H5eB/eU61KGSc7N38duQz3PUIsjzP7cjH7wiE5fCVOVZZWKCwB5zsxqU+HnjPFxVBmF
         NJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PonNbMWoqThkAKEBfztMgFnpTF3vsFT/dHecSBkyWI0=;
        b=ukNUG0Q4Jncy+B3T/loxH8/py83SJAM9Rqyu2Nc685EaO8xYpE4n8tLGRfBK/KmGAF
         dB3chlAxbXnM7YVLw2FExtWQcwcpcMDulm2xu+f0fbPwXSOUXqzgDWbvzVpVsZazI7+G
         NLGEXiBmPoJPIJvZshduLnrnV7zphVkXsTb6H9K4DlpzMxQXACOR2lpXdWvOmOQx4uCp
         n8shf/IODbIVvQCy3q9Ls9hwxf/WUxZwkSX2qUdbiYJ3yrRQXpKHwd525Zbc2bZ09J4B
         hBn/tUU4/nycyY989/u5AiQFStZ5GaOWtspzDEO9m52mV5qMd+NRzp38UKQMst/SmR/i
         6Ghg==
X-Gm-Message-State: AOAM531go7mokCAv0NFYDKS+MfMpGBUXrKXjsJq+uqC63/4EXXgAV4FN
        m4O+Hxka/3cvOokVOWGSDxKdeVhxu7zxMNUnniiveTW/EGQ=
X-Google-Smtp-Source: ABdhPJydCLohKYbKOcB9h8hzYFEURNxjQLwBp0FlPDfNzCBZqHkjkFJZ18w7MfhvjwP6mGrE/EwrZ0pvPVRdgpxHzBc=
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr42515219eje.377.1635840712655;
 Tue, 02 Nov 2021 01:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
 <20211102073300.13376-1-andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211102073300.13376-1-andriy.tryshnivskyy@opensynergy.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Nov 2021 10:11:16 +0200
Message-ID: <CAHp75VfafpEBccivDRC2AVVJbZL2Kdq2KeR0yf_nwTtDTxvDkg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: test: Add test for IIO_VAL_INT_64.
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     Vasyl.Vavrychuk@opensynergy.com, jbhayana@google.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 2, 2021 at 9:33 AM Andriy Tryshnivskyy
<andriy.tryshnivskyy@opensynergy.com> wrote:
>

Now it's good with format, but you have missed the commit message.

> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>

...

> +static void iio_test_iio_format_value_integer_64(struct kunit *test)
> +{
> +       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);

Shouldn't this be checked against NULL?

> +       s64 value;
> +       int values[2];
> +       int ret;

Reversed xmas tree ordering?

> +       value = 24;
> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);

> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);

ARRAY_SIZE()?

> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
> +
> +       value = -24;
> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);
> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
> +
> +       value = 0;
> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);
> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
> +
> +       value = 4294967295;

Is this UINT_MAX?

> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);
> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");

> +       value = -4294967295;

Is this -UINT_MAX?

> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);
> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
> +
> +       value = LLONG_MAX;
> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);
> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
> +
> +       value = LLONG_MIN;
> +       values[0] = lower_32_bits(value);
> +       values[1] = upper_32_bits(value);
> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854775808\n");
> +}

-- 
With Best Regards,
Andy Shevchenko
