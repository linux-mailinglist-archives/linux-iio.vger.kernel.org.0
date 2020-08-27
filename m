Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03813254F8F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0T6y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0T6x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:58:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62077C061264
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2020 12:58:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n3so3099903pjq.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2020 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=21aev7QBcYIDr+ha+C4vh3ugftzqC1FHbsnewNDqX0E=;
        b=eC/ul0mICtLOxcHGjqgGoDxA/sh1aAG2ufHLJfhY7+t0LpP8QE8u9mdp1kMc6myhPa
         IyeUXtwbijCx1W4mQobsg1JAHmIo+0mVpHsTj0s/MSxgvnKhTTdoPeuwQoD/UUGnfC1Y
         lO5RgGXMijIsAW6pskOEMDFhzk1hzbzC+UDt0SnYG51Vc58529Ls9MP87XVywHqmg7Ll
         BpyK7AJzbAiPIvoDssRRA8DGYGYNN2WqJMLOrfiJE8bpAT2pZkjUSnyr5ux+olNf6Snk
         SpwHQmZLoukLQOa1NWwNeKqC5U30BnCIgzCcVrD2IwbY1ql6Y1WpfGk3KS3FI9oM4m7J
         iy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=21aev7QBcYIDr+ha+C4vh3ugftzqC1FHbsnewNDqX0E=;
        b=EGUzBu/OcCdr1mV+InoyH14WFTUnI5MICURDL7lGf0ggmVSM04bqINequo6v+NNXKf
         Hd3rx4SQLd9DQGyUE5SFnVeV9KSsUnT7ZYNQyLyGMEXkCrQPtL5sDuanRKFjXjbLBK2E
         x66NJ5LqvF01bEzLCPvCsMJ6ydRUTzBteUOr7zNj6q1U9129dNj+5iQomnoczdLMoS2u
         eNiEIjUc1D8xxXLe9kxuZFrP+2xYGZmJFQM8w38bpPnMMfGGJgZfjQUpz+sZ3pPkdjuH
         O+g0Pdbl7IC7NsL3wPchN4uthO4fX3/Kd5S7alWNHyGuC8vaLNbJHMfVlU7DZooM8qRw
         V2LA==
X-Gm-Message-State: AOAM532rTVko7APbRhJGfa+KYTI9vYtzDX4eMRGKy8h9ljHvP1Y/vH62
        dV1ZzO+su9GzLsW20RxGakrr0limXvr+Lio7H38=
X-Google-Smtp-Source: ABdhPJz/hYz+P9lulRKOLCNUI/497hUZ5vR2gHerMASRsMliw118THqiNTEcNItGv5YxRMzVSfhzM4svXvKD8k8WNYg=
X-Received: by 2002:a17:90b:509:: with SMTP id r9mr447365pjz.228.1598558333015;
 Thu, 27 Aug 2020 12:58:53 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:58:37 +0300
Message-ID: <CAHp75Vdp194=twujCKqwLide7rE_y8_HYJRgEq+oD17M2hZGZA@mail.gmail.com>
Subject: Updating MAINTAINERS
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Can we clean  up maintainers to avoid spammy bounces from
knaack.h@gmx.net and others (like beniamin.bia@analog.com)? First one
is really annoying (not only Krzysztof series).

-- 
With Best Regards,
Andy Shevchenko
