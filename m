Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5C23EA49
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHGJYK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 05:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgHGJYJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 05:24:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC287C061574;
        Fri,  7 Aug 2020 02:24:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so615826pgi.9;
        Fri, 07 Aug 2020 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMIBDjoYAKT/tZ7tKzZbXzm+tNk622/tQYqsrlpXYP8=;
        b=apEb6i7C8WWOMBltvG5q0fzq7eXLMPsVlVbNdlkoIYnoYek8yWNy7Z4dSlj+JBvisK
         EElsgcX0ryvhQRxQbWaFPzzEiEbVeuU45bW6Vj+TRMpgzwCO8Ui+2tkbQaqiH+9UTv4K
         bg2axQeb+6Nq9X3V5nKPgZvJbqm2QBz7a8XSVhNlq9ALCQEseDfFrIKGbyYT6kF8v+ce
         gHKjXyohF2lqZRk2oAGwREby4LdYNS5vR4rn6vupIIfd5Up+d8n+zT69jltTwdVHG6rf
         Turn9ka8VYUrHkamTqNihr+/2rKPBbHKDYJUkDUmE3ZSDsv8W6aof++rsW6+t+6+avCP
         1Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMIBDjoYAKT/tZ7tKzZbXzm+tNk622/tQYqsrlpXYP8=;
        b=CcyBzc4GDNWoZmkPZVHnewHhbty6yy3oMxmyPEX3L2tzwbHkfFwdifV5FJrWhBH7DX
         CFyqc8f6IAaLqRLszTnINXZCObTMa7jqWkmPVRORYLjTP8IFiEUDZCNJDFRSStiyW00b
         /abAJ6Nra+zFZ6p4WxYDhj1ZeuzXH9zMiyMDqduJU0ZrCoz2HKtwTBuVrv9W8QI0Cwgp
         FovjNNX7w4pouAa1KBP4VOBClauA3rQ/f9TYjJqaVN1dhaBLZO4RqnBEOKbFMVtDUqmZ
         kbiq+9M15khLmZq1VA2dncU67f+N5PvdBYWlcJho27kG+3QoZ/0M6wF6kaxleOCW/zOt
         sbGg==
X-Gm-Message-State: AOAM532xDs8c9HW4lFDYdqB9MMTJJncqcdDnNICXFmlQvcmWZD20z+GL
        rxXRgDbFs+oksXJPRVvXW1BWuzlJ1G4JXaOOKXCDesacmtw=
X-Google-Smtp-Source: ABdhPJyPkOoY4olk2k/u38gaHFMWE9LqpyqGBx35u/7lgFZGCtXoioKKENzeNIZRDZ0wG5GBGPEQFjOyjX97fJot94c=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr11951803pfc.130.1596792248270;
 Fri, 07 Aug 2020 02:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200804100414.39002-1-alexandru.ardelean@analog.com> <20200804100414.39002-2-alexandru.ardelean@analog.com>
In-Reply-To: <20200804100414.39002-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Aug 2020 12:23:51 +0300
Message-ID: <CAHp75Vf3TD7gL2+Rjga-F5M_yANV8COMRrpo6iKdFKYfssafPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: adis16480: Add the option to enable/disable
 burst mode
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 4, 2020 at 1:04 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Stefan Popa <stefan.popa@analog.com>
>
> Although the burst read function does not require a stall time between
> each 16-bit segment, it however requires more processing since the
> software needs to look for the BURST_ID and take into account the offset
> to the first data channel. Some users might find it useful to be able to
> switch between the two modes.

...

> +static struct attribute *adis16495_attributes[] = {
> +       &iio_dev_attr_burst_mode_enable.dev_attr.attr,

> +       NULL,

A nit: drop comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
