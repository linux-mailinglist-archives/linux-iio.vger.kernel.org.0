Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C181228520
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfEWRlI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 13:41:08 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:51564 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfEWRlI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 13:41:08 -0400
Received: by mail-it1-f181.google.com with SMTP id m3so11211206itl.1
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2019 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LSz3GKBfMKLKdsF1uhPphbJSZW3XtoIapICUWvu+ByM=;
        b=bY6g4KDfLZBzaJIOP7pgcPiTS7RmSjKd0NLbSN0PPfxjJXHZl7BMIiqPfLAHKBcLk8
         w4XbMjiX2+otCyRfn85Oe0HAMg/+jF/lEan6JUQkoiPMiyZXfiTfWqulQ+rL+f7mgl7M
         eDNnhc3MANrt8lE7KgMT95BxIKFTLv5PMQJfUR7tJLyOrhFEtSx1LbN6mVRTx6cvmzfl
         NlBsgRgeLzV12qzgGJOqpJ35Dt+dVzrOIx0PDGHXBZTG5FTEF/qfE8xockLi61lvtl2d
         08r64umrwaDxT694F88sBUHRyHPcXG7R25aSCARVUqJl92dCqL2oSXP1AISaxJPaW8Ge
         JJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LSz3GKBfMKLKdsF1uhPphbJSZW3XtoIapICUWvu+ByM=;
        b=CILCob5lHzfHGYlOIo1jslJOJXAjnU1eUGdB+MVRJCpd0CqMsHw6IwXE03T6I6JKpi
         tByrfNsqQt6mtiMR1Me3Nk8PKNTvFSboh44gdnOzlguo6hLmTwXJ35amCswWcv15UDND
         ZeY2nWZqeO2c5DUyX2UAakbxkU1+FDKPecdWoNxKuvYstWJfvOqV6fyM0mNyuTMAGWDA
         B2JK7XREytKZZx1dkQvzEIILTrBlk+kzkGRDPRydBvqgtwSDp6WSzwIKGkQY2DYG8Pci
         OzZRte6Ra6ixrJoPSbaOo8OcJzD1FOTg+jtk8miGBzI1B7pDidbqu2TelOuJaNv08vs2
         GM3A==
X-Gm-Message-State: APjAAAWNoXq3Zt5zszF5wYZbyLrzc/fil76clhmj7MrpZ1bSuY73qGCX
        uJMtSlDENV+fpZ0nSNOJGHeXH5La7lkKQ1vXHgnkKO4fI04=
X-Google-Smtp-Source: APXvYqxbqR9VtHK3/x5K85R3UYo2RwF9Sv5gGu/lIP+tEASSNkkN9X2/EQF1BrP303P1vNBFdT8fCldGVI37n2+g72I=
X-Received: by 2002:a24:210f:: with SMTP id e15mr14040136ita.122.1558633266994;
 Thu, 23 May 2019 10:41:06 -0700 (PDT)
MIME-Version: 1.0
From:   Enrico Granata <egranata@google.com>
Date:   Thu, 23 May 2019 10:40:48 -0700
Message-ID: <CAPR809vPoRgL+zd1juQ3u=couoF=Ef=dUi90hx-t=a31Vs6v_Q@mail.gmail.com>
Subject: Question about having multiple timestamp channels
To:     linux-iio@vger.kernel.org
Cc:     chromeos-sensors <chromeos-sensors@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
on Chrome OS devices, the architecture for sensors (such as
accelerometer and gyroscope) involves the sensors being connected to
an embedded controller, which receives interrupts from the IMU,
collects samples, and then sends an interrupt to the main CPU running
Linux.

On the CPU, there currently is an IIO device called sensor_ring, which
handles the interrupt by collecting the samples from the EC, and
pushes them to an IIO buffer.

As part of the EC --> AP communication mechanism, we collect:
- the time (in EC clock) when the sensor notified the EC;
- the time (in EC clock) when the embedded controller sent the interrupt;
- the time (in Linux clock) when the CPU received the interrupt.

We use these values (which we call respectively "a" "b" and "c"), as
input to a median filter in order to both convert EC clock to Linux
clock, and to smooth out jitter.

We have since come to realize that a median is not the best filter for
this task, and - as part of a larger redesign - would like to move
this filtering in userspace and use a different filter (most likely
either a least squares or a Kalman filter).

However, doing the filtering in userland requires us to be able to
send the a, b and c points from the IIO device on the kernel to
userspace.

My initial investigation led me to using indexing as the most viable
option to have multiple IIO_TIMESTAMP channels defined for the same
device. However, I spot a few places in the IIO framework where
channels of kind TIMESTAMP seem to have special meaning.

Is defining multiple timestamp channels via indexing a supported
operation? If not, is there any way to define such channels? Or a
better way to support our use case of providing 3 "timestamp" values
to userspace.

Any input is appreciated.
