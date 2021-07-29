Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744963DAB96
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhG2TDu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhG2TDu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 15:03:50 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069BC061765
        for <linux-iio@vger.kernel.org>; Thu, 29 Jul 2021 12:03:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso6931960oth.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jul 2021 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=u4+SxYRJC4Z8oRXLpD/mQAXV83r+D9avQWx12ORdvvU=;
        b=e97vARARkpCc+WPYWj0DhxcwMc5O/esq8kBjM1hNnRGF9+GMbcpmilUQjCtVCrJtBh
         Lnx1zoL5QAcpqIjg1Yop30PcoKLtnEMas13gy6ZTWXmuBIyXptS+rGvXCGb6vjCVZrVE
         sF5sQEqzlACPbx8DFXFhwJfGyjQ3kih85/Ke8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=u4+SxYRJC4Z8oRXLpD/mQAXV83r+D9avQWx12ORdvvU=;
        b=H4m7trsoXRkbPeZEcXr6ufSNRPIB/Hb43tPFY49E996mA8EDIl0lSC2rReEqs8ZoK0
         CMXW//VN5uMFG9Le9wEzD0PSTxk06o5P0w1eujDR2wagKHoRe111vC9zrAc7UsXQuezy
         Muf9GWwJQZmN7d40XRX5p/8Q0mHVchM1awIjMn1Zie0X4l6RqejO08TfyyIL1tip4+Qa
         EoaEHZpNpEk2MSJLoCejpLv1ACRCxWjs4D1bBQH5pprHTDXuID3HKNSAGIr6nd53/ZKX
         MXSb6HnDi2eA+on5BrwSfqbrIPu3J5Otv8B8y+gyl3ycpIUH2QSiAub8nZ63HRqz4+Wb
         nkgw==
X-Gm-Message-State: AOAM532XcW2irQ8CYSoXJOBOogUbuRDnfLOzAETwOLD8Z8XiWNxu5ioK
        3awkMFz6IN9YBBJP3SIKtZrU8YcEglUt+WbGBEkXzg==
X-Google-Smtp-Source: ABdhPJyhvH0U5DhOJjcELq7s2KUw4D0jd5wF8cESNh8EhnKXcVWrj6Q1i00UjwxH9/i1aD8flDagdBRGLJfj9yYrFkM=
X-Received: by 2002:a9d:1b6e:: with SMTP id l101mr4445710otl.34.1627585426334;
 Thu, 29 Jul 2021 12:03:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Jul 2021 12:03:46 -0700
MIME-Version: 1.0
In-Reply-To: <20210728181757.187627-1-gwendal@chromium.org>
References: <20210728181757.187627-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 29 Jul 2021 12:03:45 -0700
Message-ID: <CAE-0n52pU_xK2kDDRmCz_fxj1wG0CdLK8+FZPq9xT9Pv_A+F_A@mail.gmail.com>
Subject: Re: [PATCH v5] iio: sx9310: Support ACPI property
To:     Gwendal Grignou <gwendal@chromium.org>, andy.shevchenko@gmail.com,
        campello@chromium.org, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-07-28 11:17:57)
> Use device_property_read_... to support both device tree and ACPI
> bindings.
> Simplify the logic for reading "combined-sensors" array, as we assume
> it has been vetted at firmware build time.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
