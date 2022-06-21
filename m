Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D4552D69
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiFUIvx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348208AbiFUIvw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 04:51:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17D26570;
        Tue, 21 Jun 2022 01:51:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id es26so16687669edb.4;
        Tue, 21 Jun 2022 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EROUy8GeR4sChoZcrho6Wl407IX8Lw8EhpMrr4UpUg=;
        b=UGzGDOHyCy/i6/UwdWmj+jWx4MFbPLPZ0aI7Twxi2GErH/53E02alQwwtku2lrgOFd
         meOf+KoLtwr5zdobckzDpV0hvAVo3R1W0kXs/5TmerTG+ahW1kyrJTZZh9WbChyzVZIn
         +WNgUov779FIF0qJNGqqMnTfkLnZbYs6rFX/ZiEPiZpZhH58uNTvIz2I0KZY2cq1jLTa
         A+IJZrW4Wb9ijlhzA38BuvuXfUf2zNWZzvRuj3bKHjy9NsDx25xSpZdzCjKiGdF49E3k
         2TpufXWqsZx4DwL8bYi/9mLgoXgN4SjicH17St0F1WpOq6AbZmqdyx/8M+nF0I0KpCxc
         5RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EROUy8GeR4sChoZcrho6Wl407IX8Lw8EhpMrr4UpUg=;
        b=QA51qhakUraeEHQrjlYeUOe1K7MOxVzp4Om/6RuleRALX1HXoTy/i2f8oqTEtMRFL1
         fLioBz8aut1Z7IYp0hvtaaYBz04mDs29gGrajsRjUC8c9AH9z9JJhba+oA06ViJKdteP
         AwJZezm2u05s5hv+LjIMcDeaBUrYbAnNjLk1oqboOFu8YcRrniMgD9/45GWRrZC2I5S8
         /6POQMffdmnLptCqJ7SoLe0XwpyDYGHSMvn4HP27Mqe6i4M1fP79CQaPkvYxetq2IfY7
         9nXMWMuJHqWtOi2LXuQhqrHPe/s3C2UxgJxHtv7DvVY9CC57l0iYQlew6BP2ayn43wT1
         rwLg==
X-Gm-Message-State: AJIora8CLu8e6SKuvexdnputSvJFX8jUbCgNzsE23Q4tFQAOF28rgDnp
        H2uYufJVZmFuRRtlHx6ouFhTbQITI+TeYedFPHQ=
X-Google-Smtp-Source: AGRyM1t9gKtuiZ1pa0IGYpQEeD5VVceT1Bu7KHXpPzVXMKfVF/8/sYO/pQP5HIBuPEYL/vGNDlwTjgnPMNTuduNyqcQ=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr33440522eda.141.1655801509796; Tue, 21
 Jun 2022 01:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655509425.git.jahau@rocketmail.com> <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
 <20220618160041.15798dcd@jic23-huawei> <d3e074b8-9679-87fe-dc5a-9493f0586aca@rocketmail.com>
In-Reply-To: <d3e074b8-9679-87fe-dc5a-9493f0586aca@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 10:51:12 +0200
Message-ID: <CAHp75VfGxK8EBzwS+KDAD_VWdeDUWezDiitiNFmEfim8oN4Aag@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iio: magnetometer: yas530: Rename functions and registers
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 21, 2022 at 2:54 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 18.06.22 17:00, Jonathan Cameron wrote:

...

> Again I'm not sure on the "Reviewed-by:" tags. Again the patch gets
> modified a lot, therefore I would remove the tags.

Yes, that's right course of actions.

-- 
With Best Regards,
Andy Shevchenko
