Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2127219A157
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 23:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgCaVyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 17:54:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36522 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgCaVyv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 17:54:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so8707514plo.3
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2020 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w9DaxcRT+cPpml5Q8qGb6h5GM308S07zAXhDdjj3rxk=;
        b=jtl+fJDtL/xiCHvy3F0MCMhgRx++rNF5bwmJdBGldgIQnjdEMyrry8+djXdo5cOFzD
         u5b80+VbiB2hQPwIZI5umtwiBYaj2sAY5KIJOJXiexOTQyzj5XC+EDo/S1gsU7utmnQh
         GSCzb2YW9uPuTPqNKsQr+dGFLBlErdtDln0d7w2Q8HGtr42bEVPfoZtZAbqvD8VlfW5L
         MpgTnBeBc2x3vjRXleW6YNO6lM6Sh87cDvcvP7BoFtnvHertNc5EKE1TG0MgIkVJtg2k
         wkfpLe2O7q8eeaf7WGlWjEVfX9Ex/EfOUZptpWzze8Pzss1x+gX8BgkIv7EROByebBU2
         UE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w9DaxcRT+cPpml5Q8qGb6h5GM308S07zAXhDdjj3rxk=;
        b=oZdzHMa6QixYVPpzGtWLcFVOBao8SMyJABuG81alCU803ScDJfeTojAT/sRgUAF04L
         l0m4MV8/lhAUpP7ShJWeG2x6UWz8xgrCmyD5CwWNBLoxfYRR8F1B7mmueWW9nRlwA70H
         m+ZGyeRSvHYwLOb8xFdDhFJOeSsIeOBabSZtPJVJl9FWcOPUaCuv2vngmJAV9CANr/L5
         A/roNrlQl3N8Is54RUxgvLTFcYKfKfiRCxjPHN+3GWKCc6fYLxdqhdY29zMSbDWC//9P
         YfC9SXc8BH0pzzhLxmb4Ksqzd8Xgr07pwbQ3MtyupQeTTSlfFgwh8E9HBD6y0Ms89poU
         Yuww==
X-Gm-Message-State: AGi0PubJPSPVqYT7YtGsA3h8uGeiV8cVmgz4SylVnFaZZn9aNoGyKNBS
        jcYZAAfKuzX+htYKckZgKN8adPYdncz4ZK5Ypzs=
X-Google-Smtp-Source: APiQypI2vNTVMwRKzhiCqu7u5PGF9yLbSex8RgOduPbYgdVhr94/tuBBIbkw4mMzpx2/p03O9PrR+sBtOPPIZnAyiNU=
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr15765389pln.255.1585691690526;
 Tue, 31 Mar 2020 14:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133850.23757-1-jmaneyrol@invensense.com>
 <CAHp75VcSrej_dXeKBXXoVBg-3scUHrZuwRDrdB0Qy4vOGHbLag@mail.gmail.com> <MN2PR12MB442295EC389A438B13D4BF1CC4C80@MN2PR12MB4422.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB442295EC389A438B13D4BF1CC4C80@MN2PR12MB4422.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 00:54:38 +0300
Message-ID: <CAHp75Vf2W3WO4J=28rdw81yW6Bk9tpuXuGpda6s34Hpf74_K7g@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime power
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 31, 2020 at 10:46 PM Jean-Baptiste Maneyrol
<JManeyrol@invensense.com> wrote:

> by reading kernel documentation, I was thinking that PM was excluding thi=
s possibility.
>
> Quote from power/runtime_pm:
> "The PM core does its best to reduce the probability of race conditions b=
etween the runtime PM and system suspend/resume (and hibernation) callbacks=
 by carrying out the following operations:
>         * During system suspend pm_runtime_get_noresume() is called for e=
very device right before executing the subsystem-level .prepare() callback =
for it and pm_runtime_barrier() is called for every device right before exe=
cuting the subsystem-level .suspend() callback for it. In addition to that =
the PM core calls __pm_runtime_disable() with =E2=80=98false=E2=80=99 as th=
e second argument for every device right before executing the subsystem-lev=
el .suspend_late() callback for it.
>          * During system resume pm_runtime_enable() and pm_runtime_put() =
are called for every device right after executing the subsystem-level .resu=
me_early() callback and right after executing the subsystem-level .complete=
() callback for it, respectively"
>
> The 2 suspend callbacks are also locking the device mutex.
>
> But I can totally misunderstood the situation. If you can confirm if it i=
s the case or not, that would be really helpful.

I have re-read the thread where I remember traces from. So, it was
rather IRQ handler context. So, in here probably everything is okay.





--
With Best Regards,
Andy Shevchenko
