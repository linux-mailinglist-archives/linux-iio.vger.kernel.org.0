Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57F236C8A4
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhD0Pbu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0Pbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 11:31:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7AEC061574;
        Tue, 27 Apr 2021 08:31:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso7428882pjn.3;
        Tue, 27 Apr 2021 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlT55eDRLRMC68OgsxtoMKsNvSDlBl3a8sRcKjxQNro=;
        b=Hsrl4pcZEzqOhzhrdTOljEvfQ2Y0w9RhmRposz67Ofezf2bX19lLEj4spo7KcC8lYC
         pdypJ7c4EtrL08419WDnWhD0AbImk3ThLjzE0LGr+vjLXj7KmEp3iZz+xGUt5gWs1cUs
         S7MqHYQsti62PNNb4f2uZpv7SHu2UyeWvyz7yl+LW6o0zOpT15NF7txKYHk2jf43LVhC
         SO6JNQ+t7jUmKXvYgT3znTk17QfhoWczK9qewsCy0YAeAn+aWovww1KWdiHBGBh6aJ1/
         BEQhO0nK5t4Q7Sq87T8h6982byoywG1sVE9paKWUUEyBAXaWUo8XkSgNZyNp32goJzx+
         ekfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlT55eDRLRMC68OgsxtoMKsNvSDlBl3a8sRcKjxQNro=;
        b=SiTKmAFra/CoUJb4qe8c4Ro9poALC6DzR/dn0sgt/QjBtnRSTYzzZgGozSY7At15vE
         o9btYbaXp6FHUopZtDxoh2U+0FS8TATlErcGypWCabql3ba4J3Qh5mv0ZuQO+rfoDQaQ
         DVzYmZpOdQQl5LJQXZSAFWu5mfd1w45VIcSxwuHMhUT+1e7MITWtV2WsooHJp3FrVYjz
         kkKvUohYcDVSSmAwY6onFaNG8DPDSUx00brzmx3PLxFr0EhtV7GqhpKd02h3N81/zi8/
         W+wwBVEuHgTLmZ3nhyso7aPlGGmhNch8zdTzeSZLgsz6q3Ev95+PQty7yZRC2CqoapSO
         hzQg==
X-Gm-Message-State: AOAM531X6vTBreyvyIu9J6jt1zqK3qIk+XVSNowgwEqDblZYAz9TJsit
        4kmjkZdu85F++01xzFKxvZFyieVbxzwYOK/Is+A=
X-Google-Smtp-Source: ABdhPJwHHDqr6o7NKershRtJgu3HsYsg9QK8K4jG405d1cw6qHyCoCAYBGxal5Lc9rvzbi4Ymuxfn6gGYmRYFUAXguw=
X-Received: by 2002:a17:902:e546:b029:ec:a7f5:2a88 with SMTP id
 n6-20020a170902e546b02900eca7f52a88mr25297336plf.21.1619537466620; Tue, 27
 Apr 2021 08:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210423101951.2876009-1-sean@geanix.com> <CAHp75VdEHy0-F-pg8sSUF5FK=NfDgBuDj0wLWqpGjpqE11mjww@mail.gmail.com>
 <5110607a-c94a-d833-fd7d-52bd40d35b79@geanix.com>
In-Reply-To: <5110607a-c94a-d833-fd7d-52bd40d35b79@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Apr 2021 18:30:50 +0300
Message-ID: <CAHp75Vfgk7-0jg1K9TqkBcrkLe4B22RrbpMswGGkVSN5OrkWzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 27, 2021 at 6:11 PM Sean Nyekjaer <sean@geanix.com> wrote:
> On 23/04/2021 14.51, Andy Shevchenko wrote:
> >> +               default:
> >> +                       ret = -EINVAL;
> >> +                       break;
> > return -EINVAL;
> >
> >> +               }
> >> +
> >> +               iio_device_release_direct_mode(indio_dev);
> Hi Andy,
>
> Thanks for the review :)
> Will have to set ret in order to clear the direct_mode();

Right, thanks for clarifying!

-- 
With Best Regards,
Andy Shevchenko
