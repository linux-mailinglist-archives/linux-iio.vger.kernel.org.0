Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE322262
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfERIyF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 18 May 2019 04:54:05 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45136 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfERIyF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 04:54:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id AAFEC9E83F0;
        Sat, 18 May 2019 09:54:03 +0100 (BST)
Date:   Sat, 18 May 2019 09:54:01 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     =?UTF-8?B?R2HDq3Rhbg==?= Carlier <gcembed@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Buffer size for iio_push_to_buffers_with_timestamp()
Message-ID: <20190518095401.5d95abf3@archlinux>
In-Reply-To: <7d412499-a8d3-6074-6566-e4f99bd77f45@gmail.com>
References: <affaf789-9292-20b6-010c-8cb8ef75e177@gmail.com>
        <20190511094824.5f57f6fa@archlinux>
        <7d412499-a8d3-6074-6566-e4f99bd77f45@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 May 2019 15:53:44 +0200
Gaëtan Carlier <gcembed@gmail.com> wrote:

> Hi Jonathan,
> 
> On 5/11/19 10:48 AM, Jonathan Cameron wrote:
> > On Thu, 9 May 2019 12:54:34 +0200
> > Gaëtan Carlier <gcembed@gmail.com> wrote:
> >   
> >> Dear,
> >>
> >> I have a question about the function iio_push_to_buffers_with_timestamp().
> >>
> >> How kernel knows the size of the buffer ? Should the buffer always be 128 bits (with last 64 bits for timestamp) ?  
> > Hi Gaëtan,
> > 
> > All fields in IIO buffers are 'naturally' aligned and must be power of 2 size
> > (8, 16, 32, 64)
> > 
> > This function is a bit 'odd' in that it needs a buffer that has space to insert
> > the 64 bit aligned, 64 bit timestamp.
> > 
> > So if your devices other channels fit in 64 bits then your conclusion is
> > correct.  If you have more channels then it may well be that the buffer
> > is already greater than 64 bits long before leaving space for the timestamp
> > and hence your buffer may need to be 192, 256 etc..
> >   
> Thank you for your reply.
> 
> > Hope that answers your question,  
> So, I still have a question. How IIO functions knows how many space is available because it handles "void *".
> Is the size of allocated buffer stored somewhere ?
There is a cached value stored internally because the kfifo has to be
reinitialized to handle the correct sized buffer (amongst other
things)  This is computed from the descriptions of the enabled channels.

See iio_compute_scan_bytes in drivers/iio/industrialio-buffer.c

Note a driver should always be able to work out it's own answer to
that question. There are often more efficient ways of doing it
in a driver as it knows that all channels are the same size for
example.

Thanks,

Jonathan


> 
> > 
> > Jonathan
> >   
> >>
> >> Best regards,
> >> Gaëtan.  
> >   
> 
> Best regards,
> Gaëtan.

