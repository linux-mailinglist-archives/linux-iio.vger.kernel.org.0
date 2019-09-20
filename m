Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4729CB88BE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 02:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394192AbfITAxs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 20:53:48 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:33906 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393910AbfITAxs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 20:53:48 -0400
Received: by mail-io1-f51.google.com with SMTP id q1so12368085ion.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b90o8YBAKCOBNeaJPdUax3l29PsFV9YkNMxK/T3G96g=;
        b=DBlfTPwUjWDFnQN2dbOMGW2Kxmur+e2j1Cj2x+y3a/KuBe4YxANmXI5asHuhgJUIKg
         /PHcG5icPjVjYLgCVryWxEqq7E78jyYXOkb/+L3mkrUEDFEWHvRaeK6Svt9Z2jCs2jnD
         SfNSeVsZ9tqKXyKWkwWsJ4rxbo9KhQbz/rEwoF6t+pJFGK5Jqno3zYkGA/GIm0VmQy4b
         yjPRubY6Dw7URb77zjBX2molLHKTafsK5LD82KNkyATNT5o4KcL5tVB1Hdi6MLFzJvOX
         CCYGaq1JGQumZF3H8T+DqtE2d/8v5S+u8Wrw2nm2p8z039IRKHYuCohjlxi0fOAJPwyr
         /SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b90o8YBAKCOBNeaJPdUax3l29PsFV9YkNMxK/T3G96g=;
        b=Xd6ZYMD6+OndIiq+s44UMGoXgYAgrwjXXDd8uA2tuf79b6GMR/eAJhSXcI/tsZXhqs
         a/cHUa1jIPsv/SxNgLgLKk8bdZIW4RbUW5zcPy6+CmDA50rN3wPgn7QQyPpXWVTgWQIw
         GUrVLR/OqwhYtFjAQLeTzEoqHf13fF9BIRKlZcqtDEwYgv9QV0J+OPtz6fkcHtNNqeTJ
         +qMvGDbx2ZZbjBK+Z71UEgiaE5J0E+kK/v5rcFRQNDRMXaoI7burFfuBlPGHstc6Wckc
         lfpRg2w89sYrPV9p/MxNQjjTLqQqZ5J8j0Y9KGYVFjQyBRuPBoxikp09o74gO1HUqFXc
         3QlA==
X-Gm-Message-State: APjAAAXEqMH9B75axo7d/wmDn4fF7c4AG0Q0+0FqdNO7AkWfsmVP10VD
        Yw7yyd5Vj0DX9vi6J2D8Zm/a/gvSdky+ISSnEADyBQ==
X-Google-Smtp-Source: APXvYqy4PofA6CMLQPQ5tS2VY9PRXRTeoxnaUmZkkhOs1ExbMZba0/tGV4IHmOdWcnZ96g5lmD+kdPF+XX19dOjMjz8=
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr5369750iop.181.1568940827454;
 Thu, 19 Sep 2019 17:53:47 -0700 (PDT)
MIME-Version: 1.0
From:   Bobby Jones <rjones@gateworks.com>
Date:   Thu, 19 Sep 2019 17:53:36 -0700
Message-ID: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
Subject: LSM9DS1 testing with st_lsm6dsx driver
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo and Martin,

I'm testing the LSM9DS1 support recently added to the st_lsm6dsx
iio/imu driver and I'm encountering a device tree problem related to
interrupt config.

Here's the exception I'm seeing:
[    4.172529] irq 277: nobody cared (try booting with the "irqpoll" option)
[    4.179341] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.3.0-rc5-00322-g792b824-dirty #7
[    4.187359] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    4.193920] [<c0112750>] (unwind_backtrace) from [<c010d018>]
(show_stack+0x10/0x14)
[    4.201690] [<c010d018>] (show_stack) from [<c0c2bfc8>]
(dump_stack+0xd8/0x10c)
[    4.209027] [<c0c2bfc8>] (dump_stack) from [<c01923fc>]
(__report_bad_irq+0x24/0xc0)
[    4.216793] [<c01923fc>] (__report_bad_irq) from [<c0192820>]
(note_interrupt+0x27c/0x2dc)
[    4.225078] [<c0192820>] (note_interrupt) from [<c018f174>]
(handle_irq_event_percpu+0x54/0x7c)
[    4.233793] [<c018f174>] (handle_irq_event_percpu) from
[<c018f1d4>] (handle_irq_event+0x38/0x5c)
[    4.242681] [<c018f1d4>] (handle_irq_event) from [<c0193664>]
(handle_level_irq+0xc8/0x154)
[    4.251051] [<c0193664>] (handle_level_irq) from [<c018df58>]
(generic_handle_irq+0x20/0x34)
[    4.259510] [<c018df58>] (generic_handle_irq) from [<c053c348>]
(mxc_gpio_irq_handler+0xc4/0xf8)
[    4.268313] [<c053c348>] (mxc_gpio_irq_handler) from [<c053c3e0>]
(mx3_gpio_irq_handler+0x64/0xb8)
[    4.277287] [<c053c3e0>] (mx3_gpio_irq_handler) from [<c018df58>]
(generic_handle_irq+0x20/0x34)
[    4.286089] [<c018df58>] (generic_handle_irq) from [<c018e550>]
(__handle_domain_irq+0x64/0xe0)
[    4.294810] [<c018e550>] (__handle_domain_irq) from [<c0529610>]
(gic_handle_irq+0x4c/0xa0)
[    4.303181] [<c0529610>] (gic_handle_irq) from [<c0101a70>]
(__irq_svc+0x70/0x98)
[    4.310675] Exception stack(0xc1301f10 to 0xc1301f58)
[    4.315744] 1f00:                                     00000001
00000006 00000000 c130c340
[    4.323937] 1f20: c1300000 c1308928 00000001 c1308960 00000000
c12b9db0 c1308908 00000000
[    4.332128] 1f40: 00000000 c1301f60 c0182010 c0109508 20000013 ffffffff
[    4.338762] [<c0101a70>] (__irq_svc) from [<c0109508>]
(arch_cpu_idle+0x20/0x3c)
[    4.346180] [<c0109508>] (arch_cpu_idle) from [<c015ed70>]
(do_idle+0x1bc/0x2bc)
[    4.353594] [<c015ed70>] (do_idle) from [<c015f204>]
(cpu_startup_entry+0x18/0x1c)
[    4.361183] [<c015f204>] (cpu_startup_entry) from [<c1200e68>]
(start_kernel+0x440/0x504)
[    4.369378] [<c1200e68>] (start_kernel) from [<00000000>] (0x0)
[    4.375309] handlers:
[    4.377645] [<62052c0d>] st_lsm6dsx_handler_irq threaded
[<f2004b92>] st_lsm6dsx_handler_thread
[    4.386484] Disabling IRQ #277

Here is the associated device tree node:
lsm9ds1_ag@6a {
    compatible = "st,lsm9ds1-imu";
    reg = <0x6a>;
    st,drdy-int-pin = <1>;
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_acc_gyro>;
    interrupt-parent = <&gpio7>;
    interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
};

Let me know if I can provide any more information.

Thanks,
Bobby Jones
