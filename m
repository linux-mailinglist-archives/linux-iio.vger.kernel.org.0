Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719E8468B99
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhLEPLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhLEPLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:11:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED25C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:08:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so32098275edb.8
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOGWedr15SOLbPU/Ly9Cuwt1mJmbuy4E1PfVu/vXsJQ=;
        b=VsEVy5JG2d/iPvLE4Cbv3NSsWDul941e/CnjlHRjzXZoq5I7E/meaoB23oibYdmkwy
         /SOd1SI8XY/E6Vv0HERJcUCJxTlYCtxQK0Y9/8wPrvYKPROoR/HJ8rdyGd/6XsmU7ZPL
         Ofxr8ftIS0MNgt1phnP4U1mApyU7PENcL8aG6sPQUOUOEcP4BbBq1NMKb/QC91xA4SOp
         y4hHJArR7gCbHDlngekLOk0f2bDkBEgxBIp0tfu65RiabntONejPOHOyZLSdCceipMHj
         4WTsn1/lISvItprWBObGsjuP1STjNMPVC1hXfG6rlx3kjcNr8eXcbsUSy94UUbhf8RYW
         AtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOGWedr15SOLbPU/Ly9Cuwt1mJmbuy4E1PfVu/vXsJQ=;
        b=WKuKHbgZEJlsb5HfF2lz/43FSW8fk6DTHqvlOmS1lybvHjV/hhDhRnRJPseyz1yuUz
         haCuyoZCHrlLCXh7v4S/NI+NsNJ89QiInc5dlBG5hdJNd1NgVri6taiAOmKhIBMTQYGu
         2JaYhKSmwW8WrLD+oyP66a5MtrJwab6rjIF5Nbh8tDXOljkrTfgErzxOn7YkkS8LB6eK
         bEz0VIDWcTB7n5Ip70K7Kx6YTpONvqCF25ZSgcb6TVfsiSeu8oXnNYOADKjT288O0Pem
         Wx8qgvMIJ2YNrWjtF9CzhiwobnZIA7621AYRFk1W9vpZIdZhaDjJXzmtBp3/BTmmQeJU
         luZw==
X-Gm-Message-State: AOAM530O+AvlveXKfcXn54N/UqQNr87+99Mc3rlbxDnTnDMPR4DijpnE
        dbMhJMmK7+sDUe2F8251Q42r4hlaVq6ndf8IvEk=
X-Google-Smtp-Source: ABdhPJzMd8Lor7LT6Vn2nKof/nBNCdSPxIR4eRU7ot22fclLFAjQ/m1pHZGXWSZcK8zLL0XIfQauFZHOiJYlhC37f6E=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr38120657ejb.128.1638716893135;
 Sun, 05 Dec 2021 07:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <20211204171237.2769210-9-jic23@kernel.org>
In-Reply-To: <20211204171237.2769210-9-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:07:37 +0200
Message-ID: <CAHp75VfBYXchpvfpXrHoButYFZ8Hy1h9XPYu=Qyo8vZy2SKhqw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] iio:adc:mcp3911: Switch to generic firmware properties.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This allows use of the driver with other types of firmware such as ACPI
> PRP0001 based probing.
>
> Also part of a general attempt to remove direct use of of_ specific
> accessors from IIO.
>
> Added an include for mod_devicetable.h whilst here to cover the
> struct of_device_id definition.

...

> -static int mcp3911_config(struct mcp3911 *adc, struct device_node *of_node)
> +static int mcp3911_config(struct mcp3911 *adc, struct device *dev)

I am wondering if the device pointer is already embedded in the mpc3911.
It might require assignment reordering in the ->probe(). though
(haven't checked).

-- 
With Best Regards,
Andy Shevchenko
