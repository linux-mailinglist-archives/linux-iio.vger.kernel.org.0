Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E496198351
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgC3SYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 14:24:45 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41093 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgC3SYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 14:24:45 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so13219411ilj.8;
        Mon, 30 Mar 2020 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vb60ZKVrPR+7lUjzvQVj0TYyeHury9tAevngqdCfDhE=;
        b=POVqLOteVZRnU2iuw+JQb1UYnasknNqPZdpCx0FB+6K7FuuJ7m5m6mEKHWE6TlcOos
         0Diox5mBgrAeBfDmeO5m4DiTGXi1FDMNV3Z0OLRNmxGve8hr7x8jLcBFmsFrXM2ND3cY
         81jZKk+7I1OS/UgVpP2dufwbvSo0kz+ADW5wjNM7eD/YDzBwEGLWzJqGj9PfSzU3/Qzg
         mtCG42OIsqJV5cASCjob/eBtdjPyTjImV+1mlpchK3eS4WUucgCiSD8GABAmHQwdxn91
         sXDjzzULkHHd/SrQ26sbko/mreOZGab7H0CdnqoaHL3MWC/P7q+o3JQH6Svad/2MvIUo
         xPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb60ZKVrPR+7lUjzvQVj0TYyeHury9tAevngqdCfDhE=;
        b=KesPkTbZL14bJXOM1KhlPOhUEvQ6kY8SeaOEdlR0ZCW35kZkoSqwqOK1OKpqrr+xPG
         uq+afEVeIjUGrv8zrDdQyuE6qkCrkBZ85XAqT9gXkkdwkDc2tV4fV/W5qYgs5uuByJj2
         fhA+x6701WQ7UMEBelorlyfAn1rLqAgkeIwFHuocNKtmAR3oiqp4VtTn64PpyWqsX9Yn
         7tAbY2U6HH9TtAjhHnOSd3uq/XM7QDClcZfN+bF5L2g5tWCVVxrMsGVNvUJrdnbfOGff
         Ya4ZMbtXPThTWx1K2zx8NeVh8e8fPKsyykTVm3rKwXX98gYdIwkKvq2lWlkB6O3YPmUq
         og4w==
X-Gm-Message-State: ANhLgQ2B+LVVTlOkiaISWZxZg/Rr6mWAaNEC1LQ3Y6+YcUtVN9ZKBNkH
        s2N9BWbZzgAV517uwJq3MqV6dO6+I5o/2y9LRSI=
X-Google-Smtp-Source: ADFU+vtXo3ZRGtwaLol7PUjCnQ1OWidrDqgi2IjetQ1Esv1g1R4SmO/FqtyW5pSo2N6rqRZ/Y/EdLAp7hIhCLrxvFKY=
X-Received: by 2002:a92:9edc:: with SMTP id s89mr13038549ilk.229.1585592683695;
 Mon, 30 Mar 2020 11:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200316124929.GA389@syed.domain.name> <20200318020506.GA45571@icarus>
 <20200322175831.74e10aa7@archlinux>
In-Reply-To: <20200322175831.74e10aa7@archlinux>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Mon, 30 Mar 2020 23:54:32 +0530
Message-ID: <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic interface
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan

>Looks good.  I'm not sure right now which tree I'll take this through
>(depends on whether it looks like we'll get an rc8 and hence I can sneak
>it in for the coming merge window or not).
>
>So poke me if I seem to have forgotten to apply this in a week or so.

Gentle Reminder.
Thanks !
Syed Nayyar Waris
