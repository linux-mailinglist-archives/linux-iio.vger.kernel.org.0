Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECF225C37B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 16:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgICOwi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgICONC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 10:13:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF02C061246;
        Thu,  3 Sep 2020 06:59:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so2213930pgd.5;
        Thu, 03 Sep 2020 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opMlPiV+qCTrqLMIUDes4VFrVPPiEfzlnZNFmTYgBrE=;
        b=RqnQpRCHxdVOqQO86jG/T5EgLn0Sqfo7uj2+YjDPaNtZLjTb5An74Jh5Zl2fPuHHEv
         yGtyZ2DPzshB8kUjV9kM/QwyIOS63AeOSSAq5PK+lalg1Zz9qpKjyCR611kz7dgFD4tn
         iWKbtTyRRdhFUvlHknvyev6zle2PeudCOgNUQnPOdFMZh+kJPBa71RkIcq6UUwoG+8EZ
         4Z7hh2VnWiUhZxmdBd9U3fbJd5oIHZMbkAhj8PPZqL1BeOomg3csex4LS8mpdpxUCvlQ
         7CBWfOTo7l/yMKb9CeZEquaLo8bBg8abCAuNsbQNhGN9slJmVMj1qhkgFBHk+HUyuvQO
         /mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opMlPiV+qCTrqLMIUDes4VFrVPPiEfzlnZNFmTYgBrE=;
        b=Z1ltWpl1sFaKpLplKp1rCokeUEueauvFcy+0+k+OgMK8fvcr1vPiRwU/8G1QFAqHxz
         nHEUK3r/xh7OkP6Soqpmy5DzXREAOgezt+M4tdebyKlPEPxRWYt5AM8kzIh11rQ/HOvd
         lLqtXVLPLJBjo2aTd00t7IcpfiN5BtxNVCguzvqNOrg71HUpBgYHF8ju12ibvcT2ixzr
         zQN+WRNXX2qWp9mZn5XmsOM7gh2EHVrekjWPjjogoOakoXOuRbDYob81+MVH/BM1netk
         dge+OjjcQc07nOYt7sJPH4tZg3X141toJf/fB/HKIrkcgCREDYjV4L4JatPC+BhG/rOa
         PTmQ==
X-Gm-Message-State: AOAM531QIlIZBdlhTC00ZibhIPlsOeXmnqDZptW6AiC6yEpovvQoL/vN
        k0nqo3jDMoJlmMwITPfY96EMcl0QkAwlhitz4/8=
X-Google-Smtp-Source: ABdhPJxpf4/VgVQE4XDqwhc38ETZmIKw3GLkPuTdNcyypXPRXxpk7cDONZDlW3U24ckzCr7rNoXp/yktfBHEQfx/zTk=
X-Received: by 2002:a63:c543:: with SMTP id g3mr3127878pgd.203.1599141569482;
 Thu, 03 Sep 2020 06:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
 <20200903130950.6274-4-nish.malpani25@gmail.com> <CAHp75VfReT-EjCV=cW8mV1MmoMPPdY9q1scoPwbD_DEHpQHd3g@mail.gmail.com>
 <CAEtfd9ZPkyk9_GV3h-CXFT_j=PYU66SHoYaaE7tytQxb+Q5rVA@mail.gmail.com>
In-Reply-To: <CAEtfd9ZPkyk9_GV3h-CXFT_j=PYU66SHoYaaE7tytQxb+Q5rVA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 16:59:12 +0300
Message-ID: <CAHp75Vc2UhW5yDhXs0RJZUmXABAqTX12N1NA3CWeSirHWfPCng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: gyro: adxrs290: Add debugfs register access support
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 4:57 PM Nishant Malpani <nish.malpani25@gmail.com> wrote:
> On Thu, Sep 3, 2020 at 6:55 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> Umm, I'm sorry, I don't see why'd it be favourable for us to do it
> this way. Also, I *think* Jonathan is fine with how it's being done
> now.

I have no strong opinion, so whatever Jonathan thinks better.

-- 
With Best Regards,
Andy Shevchenko
