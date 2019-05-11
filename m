Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6383B1A739
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfEKIs2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 11 May 2019 04:48:28 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57150 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfEKIs2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 May 2019 04:48:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 7B1259E8608;
        Sat, 11 May 2019 09:48:26 +0100 (BST)
Date:   Sat, 11 May 2019 09:48:24 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     =?UTF-8?B?R2HDq3Rhbg==?= Carlier <gcembed@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Buffer size for iio_push_to_buffers_with_timestamp()
Message-ID: <20190511094824.5f57f6fa@archlinux>
In-Reply-To: <affaf789-9292-20b6-010c-8cb8ef75e177@gmail.com>
References: <affaf789-9292-20b6-010c-8cb8ef75e177@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 May 2019 12:54:34 +0200
Gaëtan Carlier <gcembed@gmail.com> wrote:

> Dear,
> 
> I have a question about the function iio_push_to_buffers_with_timestamp().
> 
> How kernel knows the size of the buffer ? Should the buffer always be 128 bits (with last 64 bits for timestamp) ?
Hi Gaëtan,

All fields in IIO buffers are 'naturally' aligned and must be power of 2 size
(8, 16, 32, 64)

This function is a bit 'odd' in that it needs a buffer that has space to insert
the 64 bit aligned, 64 bit timestamp.

So if your devices other channels fit in 64 bits then your conclusion is
correct.  If you have more channels then it may well be that the buffer
is already greater than 64 bits long before leaving space for the timestamp
and hence your buffer may need to be 192, 256 etc..

Hope that answers your question,

Jonathan

> 
> Best regards,
> Gaëtan.

