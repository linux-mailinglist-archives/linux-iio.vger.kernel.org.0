Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11A51610A
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiEAACY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Apr 2022 20:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiEAACX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2022 20:02:23 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477C403E9
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 16:59:00 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id w124so10778155vsb.8
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2022 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Cv3gl7MEYJWEadacC8fV/gZvbOujcUVg8iqWdplRPCU=;
        b=ZDtblmLrNCHoLpn2SouDhitE6OQw2a/MmViyIt/SPlVnmyZChf7F1xdTRk6FrBxMAb
         f2yV6QpabkDRvPwfZ25FNWrOBiYrmHUWS6UUAXQPwuaSkQLRJvhvCuk5vkQvmXa0a+cq
         EmzHTRWlPww7j9Y8pmQz3CRrXh4EKGiETfJbcIu8Uws53Ax7/J2NupWhaRi2aNgaWsU6
         xpW9fJo2c8OKRJIJxEpeQRWsAts+wIOgc1B7mkdwrC1IQlgLeREE+Vdew35kQwD7eqpB
         8M/CQDKSr2SkG52k6A/C4gwcOr9l9nHpq2YAciQPL3ugtqtmt+UAE6lFtmATiKszC3nP
         v4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Cv3gl7MEYJWEadacC8fV/gZvbOujcUVg8iqWdplRPCU=;
        b=oeOBxUw+/hA8XWIt4uAe6qoOzmsgDpnFyPX4W5BXnBOEW1k9LDcBsIzdK1Jy4rvRUN
         wLBo+9dVdcu+AhpW5YD4wblvwd5CR0BODbRi2XHwWbu6GuPsJRnKX+aueFoBM9Llz1s0
         5y9EklVapdHeWrniO4PqQ4UaVLj9+N9pY3Ga5PZswUcipZXesXyzaa5HEO7ZlotdG5Ws
         2nZjA1DSaMFkSjaIcSeYHJNll7Lg0a7lQNd4v7K2E2ZpMGypJB/Lns0oHMEBOihNdOcj
         VT9YbiCLRHYtopax24qe2asiAHJxxCIU9TTK9zXqlv4lZk4Pk73+n05rFrkfY/fuLJKA
         Rupg==
X-Gm-Message-State: AOAM530sK7uWy9/mF8nuC0fTUahrC+97Cga11ABH9rWBWChTVWdYz6YA
        RejUhiF5/xe74KmGxYWomDB4/AuLUKy3TDIjPUs=
X-Google-Smtp-Source: ABdhPJz/yd9K6iuDdy6v7f8HFueGGFr/xp/3d1hwEeYCT2t6334hKrnYktv34uHSPfbTSzqGi+aZrB2G2eyF36dhFz0=
X-Received: by 2002:a67:1a87:0:b0:325:3e01:45a7 with SMTP id
 a129-20020a671a87000000b003253e0145a7mr1717832vsa.41.1651363138927; Sat, 30
 Apr 2022 16:58:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3c46:0:0:0:0:0 with HTTP; Sat, 30 Apr 2022 16:58:58
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mrs. Mimi Aminu" <mimiaminu319@gmail.com>
Date:   Sat, 30 Apr 2022 16:58:58 -0700
Message-ID: <CAD-C4f4aRtNcjpntf8Ejap5gUjH3kNvxQCHSuw-jrm6D0Suj=g@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mimiaminu319[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mimiaminu319[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e30 listed in]
        [list.dnswl.org]
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Greetings,
I'm Mrs. Mimi Aminu, how are you doing hope you are in good health,
the Board director
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hope to hear you are in good Health.

Thanks,
Mrs. Mimi Aminu.
