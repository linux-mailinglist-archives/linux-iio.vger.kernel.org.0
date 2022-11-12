Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0A626B62
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 21:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKLUHA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 15:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKLUG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 15:06:59 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FA11A2E
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 12:06:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z1so5254158qkl.9
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HBIAmskrTkK4wA3yc2Bp7pBw9JWehL7gbQ7R3yUDh8=;
        b=mzG0Abnc9ZhhurnBvVXlKshOw19qdlr60WqHn/jphI06wJe1zNbDSk1N1fOv54/gCc
         ipyaJUJtLV/n0RvOXjUVCVTfwT18uoMaY0BNeGMAp1bV3ivZUxrtgXtL/thFW6HQ/piv
         1OHiTteXEC2DRRuCndr9bGj9W5ASPeqpDzJKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HBIAmskrTkK4wA3yc2Bp7pBw9JWehL7gbQ7R3yUDh8=;
        b=3lytVqdk4ZPV2TZk5x/C7J4MjxwfhqE/9OjlxnUpO7N+y0fWT96Zz7sP7d5spr4pBm
         pc459qRXZJXl8u9dsNYt1fwoqTFWSMcTx3RD+5VHRB9OYNL9YIa+TITaZbL62lvgzqDc
         jKbPbV3djnGBjOoSee7clXGxK/qZ3QE741o87HRRWFCqWOmOOZ3T8o8mhwGaqXUb5EG/
         769xxBJ7NKCZYxA0pso60x42VXi7stQCr6GqSHatFKsefADF7JBZ0tLnpYAEe9ckk50v
         4S+qhcTCUVIrkDw7ML2Mjxd7Bvs3ZE9sPRAq44WN4dyFtVUD8Vwj6lawqAz3bDrGPxiC
         TkvQ==
X-Gm-Message-State: ANoB5pmXPdirrQPKbrG5JkL0lGYsw/ZikxlTR7rRr69T9p+7bgC+xuuG
        jsTMMsclvwUmlr1svRrfjh52L1v5vclXTYMpoe1Z8Uv5lYo=
X-Google-Smtp-Source: AA0mqf6u1/W3va0198p+Y9uDqCmq125acgaPiSohXeD8Ww+Klt6aY8ELzU0l+7OOzGZMj1ribf6bfq5bMs5gdXZrLbQ=
X-Received: by 2002:a05:620a:1003:b0:6fa:23d4:aecc with SMTP id
 z3-20020a05620a100300b006fa23d4aeccmr5851708qkj.678.1668283618156; Sat, 12
 Nov 2022 12:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20221111112657.1521307-1-mitja@lxnav.com> <20221111112657.1521307-2-mitja@lxnav.com>
 <20221112171010.7a511746@jic23-huawei>
In-Reply-To: <20221112171010.7a511746@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Sat, 12 Nov 2022 21:06:34 +0100
Message-ID: <CACbQKWeiEax+u3SiUgP9k4ZD169FBkgoFwt8GG0DtQthqsqepw@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: adc: mcp3422: fix scale read bug
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Nov 12, 2022 at 5:57 PM Jonathan Cameron <jic23@kernel.org> wrote:

> One trivial comment inline. I might tidy that up whilst applying if others are
> otherwise happy with this patch.  If you do a v2 for some other reason please
> get rid of that unrelated change.

Ok, I will move it to a styling patch and fix it in v2.

Kind regards,
Mitja
