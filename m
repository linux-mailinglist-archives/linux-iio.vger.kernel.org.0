Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02DA243908
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMLBb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 07:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMLBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 07:01:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A968C061757;
        Thu, 13 Aug 2020 04:01:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so2458666plb.12;
        Thu, 13 Aug 2020 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqj1cyRcMo22JPCsUQj97oV6g8Vp6ijb+6eawSfLamM=;
        b=Rkx03hQ2ZuuoURjUOvIRaDuBT+77sPFb9qC91/eTlqfmIi0oDpxdD59Zcbwx4ysNwk
         SBfZqOCOd7w8ULkwbX7vn0XmmRd8RbXcYwodovSWjmBN7YdQWOBHvsIr6EPbQ/+mKrJW
         Yj/25zQtKRoB/2oZvy0Fnn5SAuEnssv2XwHpvl1vnE9mmsaTOzv9/K6D+6mRC5kDDD8r
         o7DJDmQgyHvbyEV/GnOnnE/F0b7rtKQCB8KubLjbu33fba+O6m+aoh7Cr+/k89JquCCt
         eb13QzlWUrGZS8owZzo0RtyiNO3y6IrQTeEvjSWiSdzBWKaxg9bPoo+Hol2iM26uWym/
         mMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqj1cyRcMo22JPCsUQj97oV6g8Vp6ijb+6eawSfLamM=;
        b=RuDLWJB+yqQ6rgGbuQRRsmzlhg3aot3fojbbR1PGU/PRAXYhaaXgQBmhhN9oIgsvjF
         MHxDwG2vQ1rpMJRyEIXPOQ1TGgmiQF57eHOMbK+dGlGoN6Un7Q4flp4BZUhWG6THWsmj
         vrUOQL1VSRtPHSRB2+DJOPzoTtXcXyY0ScLXKCdLR7oEJ/TEh34nIQ1b2huE6mn22VoP
         dZqX1Oq6rtuhyavJnV6PgK7DIC92rlMG5z1iaRTVm4iwaPrfV+wEGS/GmTYsumnPCyV+
         lIZ0CScVd5/cAdHmLL6/liGuag+OKvxrZ5i/FyKHGqHL4XwrVxroyIxCDtNXadGhHdA4
         BOBw==
X-Gm-Message-State: AOAM5313Dvhsq9CNmhRdREFUdU2t23mEnRLmeEVDZWUEOSOk6FA2phgW
        +nijGlf9JleI+zaiXlLclzsrnMUwh60yoBtJMqI=
X-Google-Smtp-Source: ABdhPJwyApNXW/87fQApRn/D5Mnf98NGzasaZ52NibTo/sH1ILmA4p4dJMx767agadys9L2kiADK4v+fuR1ECpvP3ag=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr3503017pla.18.1597316484554;
 Thu, 13 Aug 2020 04:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-6-cmo@melexis.com>
In-Reply-To: <20200813075125.4949-6-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 14:01:08 +0300
Message-ID: <CAHp75Vd0D_jq7S=ANLJ-JSTb6iD1vHVRs2cN25Y3sNWCC9L2Xw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio:temperature:mlx90632: Some stylefixing leftovers
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
>
> There is some inconsistency and whitespace cleanup performed in this
> patch. It was done on top of my other patches, but I can rebase to head
> of the togreg branch if it would go in sooner.

...

> -#define MLX90632_REF_12                12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> -#define MLX90632_REF_3         12LL /**< ResCtrlRef value of Channel 3 */
> -#define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
> -#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */


> +#define MLX90632_REF_12        12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
> +#define MLX90632_REF_3         12LL /* ResCtrlRef value of Channel 3 */
> +#define MLX90632_MAX_MEAS_NUM  31 /* Maximum measurements in list */
> +#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
>  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */

This was actually in doxy (perhaps kernel doc also understands this)
format of description.
Can you double check that the kernel doc is okay / not okay with it?

If it is okay, perhaps it's better to convert others to that format
rather than dropping it.

-- 
With Best Regards,
Andy Shevchenko
