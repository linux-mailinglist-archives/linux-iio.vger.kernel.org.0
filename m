Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F124A4522
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 12:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbiAaLgm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 06:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378569AbiAaLeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jan 2022 06:34:25 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2731C079788
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 03:23:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id w81so17049334ybg.12
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mfeb88SgNAu3DA1TovWLpJ9GU00PuBZKgL/FgGbBmOk=;
        b=WEK5URMbKWCEr+E+XSH0mpKLZ+NhV27Btn5eGtzM0qtsPnwScOdv3xZzIPTCqgEXkd
         5IrPm6HUBpHLkaMBntp2Q90o723ZIyceD03Py/EOAGUwggrikLy2WBW30V/1gqVEqzte
         m//HNeElTBBpiQnu7E14yOvYxlyN1fE2Umbli6ezeZOqMehNSiKEUDTKkUDJhSf654gb
         yZQ6W8qJbKO4paW+GirnnW2dtgHJ5YhbjinKCcaeqI/dBy8gAzoC5GPbEmHFG6nOPq9P
         w72bIYMVbxwxPaXynRmRE65tDAgfs4MUNpWyexop42dJE7znS/t6pADy+cffZbrcgrOS
         fmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mfeb88SgNAu3DA1TovWLpJ9GU00PuBZKgL/FgGbBmOk=;
        b=OwEn4HEKYzrid3af4hadqujqUhnklMo7NdL7+M2yI0prPLy8/eL3oBZSUXQ60NVXtf
         /WsaKtCvbUrpFTN8SbSFRYOTkWLgiQVrrO71WQXMxPuZik84rTPuAyw4jQmTN0sDZrAl
         TN9P3Ii3rf+0cHiTtww0+yjTJuBF9Pd6WPs6r+oQVvtEPzMqPY5tPTaRJ81kc9sVhTZS
         Izgnu/OZIKVCjPIJcW5BiQesG81Snz3hcZQ9H5sDEl8tZHvxGBCSiAMyBdhQEzd0L2mu
         24tlZKH1bF341wOG/Cq1Z5rM5/xK3lu12ftBx6h/hknHWvEFTXKVqhIyTKlGFfTQEiBj
         keHw==
X-Gm-Message-State: AOAM530zIc0GyRKvO9ATK5Fw5KTOty06o3hKhLr/Ojm4eH2RdbmVMX6F
        rUrWQHjSd9XYpDrO/oi5dUZyL9SbGCUbaBBAxi0sOQ==
X-Google-Smtp-Source: ABdhPJyJF4KcmkIVlYy6MWPxlek8Lb/gigZvypCrGUGQiwZhktVI00QkPs/ebeWHJlJba0FitxHDSwERyWccpovX9XQ=
X-Received: by 2002:a25:cfc6:: with SMTP id f189mr27662344ybg.322.1643628213945;
 Mon, 31 Jan 2022 03:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20220130034441.15474-1-samuel@sholland.org> <20220130034441.15474-4-samuel@sholland.org>
 <20220130141048.31be2554@jic23-huawei>
In-Reply-To: <20220130141048.31be2554@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jan 2022 12:23:22 +0100
Message-ID: <CACRpkdb407XmMGSM+7okOx50ZNTK3UuHWSFSH+CZ_2bQS0NJ=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: accel: st_accel: Add support for Silan SC7A20
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 30, 2022 at 3:04 PM Jonathan Cameron <jic23@kernel.org> wrote:

> This is nasty as 0x11 is a valid who am I for an LIS3DHH which is a very
> different device.

The WAI value is just a second line check anyway, the device is probed
from the compatible, this is just checked to make sure the device is
what it says it is. Annoying, but it will do the job.

> It's worth noting that a good part of the maintenance of this driver is
> done by ST employees who are probably less than happy with seeing
> a clone (with bugs) supported.  So support is likely to be somewhat best
> effort / not going to deliberately break support for this part but no
> means to test it. Hopefully we'll remember to cc you to test anything new added to
> the driver.  Clones aren't always perfect!

Linux began with people running it on IBM PC clones... ;)

I would assume good faith, especially with the silicon shortage
plaguing us it is
perfectly possible that this is a fully licensed copy. I think the two
derivatives of the AK8974 magnetometer for example are
legally transferred IP, we just don't know the details behind the curtain.

Yours,
Linus Walleij
