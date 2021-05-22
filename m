Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D638D6D0
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEVSIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEVSIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:08:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D231C061574
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:07:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d16so17386775pfn.12
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaJe4XeckA6fMx+oTvdo/CE3HQxATmnvoDblOqwChiM=;
        b=ovza31Qhhbgz0B+LflD5i33F64tAlOKI4IfnfZDxV70h7vynorQ6hmaxrQEDX0zv+J
         bT1NwqSHEelpqNLm6UcX3J8jtJtR8ivA//xx/MIjvnAV/562IEyejggnsCT9GUFKEAXt
         YHfCMLYSeVq7OgPVLq9QAKWgR6TFzfeuwDf0uk9XT97BmQ0IaHV6yb5COsykzv8X76lx
         N0Ddzd+ueSjLLRe61kTBE9GvSspiM+MZoXiVMqoXGcD2Mq5dN6El6/r/Y2JWs/moo9yx
         sHKn5R6qOGUtKyGpBMp0vU4TNzAZDA+gJnwn8NOdBewP92DQRofdXwKobUoFpWnxdcLh
         fOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaJe4XeckA6fMx+oTvdo/CE3HQxATmnvoDblOqwChiM=;
        b=G9vKPegNjXTS/U175rx39itnuZdfcqDeZShknn6SbbPHFJ6eVxaXxm0g78e4VHYEjt
         0iqHoqQwaiwlo5B6Ro6AnFf6ZHPq04ZmieOFx+GexfFoAG6P2dfeamSj95XUF6qPP4S5
         RW33yRvha6vUKfuVwwoNB7vRtJWK0iHLXM1rAre2kjITtWmJcOduIn626fstMZOm6Dc9
         ZTQ3LI8g/qMToJRIjP3iPMsEXSOy8OLzFfALu6Lup549A8SIPnwcN/N+eN4HLS9WTga8
         v9iCssrqOCm3lK+ZfqQOeLsi7+YwJSVgYagH6oXrRmU6wwxF8Qv5tEmfPoz43m9HT/eg
         fJ7Q==
X-Gm-Message-State: AOAM531PhNM34oVqw92/3rcnIMt4gt2DOmeiWjr9ztJv9lEEipz22Z2K
        03Wd6NMA/EYFeCRdAs8va7+6eiRoNsRp2zsltmM=
X-Google-Smtp-Source: ABdhPJwOM2/b3CjlqSRRXfaywp6am8NkcUNBNaQd4dr2OqYsnCANNqFxbi/fEE10s5NnHqhETIPX4t497jCk+RBiuJg=
X-Received: by 2002:a62:bd07:0:b029:2df:2c0a:d5e9 with SMTP id
 a7-20020a62bd070000b02902df2c0ad5e9mr16069773pff.7.1621706833802; Sat, 22 May
 2021 11:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com> <20210521171418.393871-3-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 21:06:57 +0300
Message-ID: <CAHp75VchPrngr5h91sfqxEPk81DHG43UkOsjhXpz4iNDagPjaw@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: accel: bmc150: Don't make the remove function of
 the second accelerometer unregister itself
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On machines with dual accelerometers described in a single ACPI fwnode,
> the bmc150_accel_probe() instantiates a second i2c-client for the second
> accelerometer.
>
> A pointer to this manually instantiated second i2c-client is stored
> inside the iio_dev's private-data through bmc150_set_second_device(),
> so that the i2c-client can be unregistered from bmc150_accel_remove().
>
> Before this commit bmc150_set_second_device() took only 1 argument so it
> would store the pointer in private-data of the iio_dev belonging to the
> manually instantiated i2c-client, leading to the bmc150_accel_remove()
> call for the second_dev trying to unregister *itself* while it was
> being removed, leading to a deadlock and rmmod hanging.
>
> Change bmc150_set_second_device() to take 2 arguments: 1. The i2c-client
> which is instantiating the second i2c-client for the 2nd accelerometer and
> 2. The second-device pointer itself (which also is an i2c-client).
>
> This will store the second_device pointer in the private data of the
> iio_dev belonging to the (ACPI instantiated) i2c-client for the first
> accelerometer and will make bmc150_accel_remove() unregister the
> second_device i2c-client when called for the first client,
> avoiding the deadlock.

I would rather call it aux device (at least in the code). The
terminology maybe needs more clarification (like the main one in the
block with the display panel and aux in the keyboard).

If you disagree, ignore this comment. I have no strong opinion here
since I don't know the difference between them (accelerometers).


-- 
With Best Regards,
Andy Shevchenko
