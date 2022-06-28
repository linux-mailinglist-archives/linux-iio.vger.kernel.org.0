Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9655F1EC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jun 2022 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiF1XfB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 19:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiF1XfB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 19:35:01 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6B39167
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 16:34:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v185so7734034ioe.11
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhcHMYZkJkC9nPKPY2nycbWiOpmZHTmBtD3VZ3pbDEM=;
        b=oJ8Zdt8Ii2k80lbVAX/HC1kFlb1ykGfPxpub9jaz06WP6LALlCIYb99UXcn+u3NmNw
         ElgLv6mxmKTbMiWy06NCL5/6JbLiWWijUmNTNR+cLQ1DZygy7mpEYOaGsKvxTgfCzLHZ
         1KRDevMJEvjC+gqifcBWOIIvXr7b0EVD3L9Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhcHMYZkJkC9nPKPY2nycbWiOpmZHTmBtD3VZ3pbDEM=;
        b=k8lyFa3NTz5TfdJaI++aD7N/TwqTyY52qBS5JtWnQKHKt1q18O4RppFgzxDyoRwJV2
         Z+EGTam0lYnOc3fRQnWs/BgAJUsWga9966aRLPy6eaZPgOgx7j7VLMxpEy+1yQc0wC8f
         Az2jUS39dSa/AxrXE4bG/9j1h0QjR0UCWpEl83JjFi+/UMEbbkbbQBHiPYOxdfabEQlI
         lMmbpakIWTMvqYf/zz5HTBkAWeymEGzTnRdVTb4iNEl2oSSnbSm/T4C043F2DIY3RHFt
         6VF4HOkQhhjaSCpKrx24EQfgtUgLFBwOZKv56CiytlbxyaT4WlNCR+KzaaeoMQKbw5Yi
         FUmw==
X-Gm-Message-State: AJIora8Th5b2/CsjmtZOs/47AaLHHxYCux1PVBobV8ceI7Mh+rfbhRSD
        HsLuvLsBPoNjGifwxcIU4EpiAu6J5ErtAH6c6W54/g==
X-Google-Smtp-Source: AGRyM1s6ya1jfCJtFFlpmKY7Q/JLMEvW1q9N82aZNdKTqFXQhDSdKPwTcumUcPCes2I1oeqWj4HGQOZ74AO7eVzIb+U=
X-Received: by 2002:a02:c4cb:0:b0:33c:ac27:eed8 with SMTP id
 h11-20020a02c4cb000000b0033cac27eed8mr347460jaj.222.1656459298424; Tue, 28
 Jun 2022 16:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com> <Yrt6FVHilUuoPrnL@smile.fi.intel.com>
In-Reply-To: <Yrt6FVHilUuoPrnL@smile.fi.intel.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 28 Jun 2022 16:34:46 -0700
Message-ID: <CAPUE2ut2+FwHHV=YxoqExet7m1R9Odji23DVB5zrGzCLgxzNdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: proximity: sx_common: Don't use IIO device
 for properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 28, 2022 at 3:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 15, 2022 at 02:47:45PM +0300, Andy Shevchenko wrote:
> > It's not correct to use artificial device created by IIO core to
> > retrieve device properties. Even ->get_default_reg() callback
> > takes a simple struct device pointer which suggests it wants to
> > operate on the real device.
> >
> > Correct this by replacing pointer to IIO device by a real device
> > pointer in the caller of ->get_default_reg().
>
> Gwendal, any comments on this version?
We can also replace '&indio_dev->dev' with 'dev' when setting
ACPI_COMPANION_SET() in the probe routine.

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
