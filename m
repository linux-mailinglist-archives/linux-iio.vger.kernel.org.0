Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA244F566
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVKwJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 22 Jun 2019 06:52:09 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51184 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfFVKwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2019 06:52:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8FF989E74F4;
        Sat, 22 Jun 2019 11:52:07 +0100 (BST)
Date:   Sat, 22 Jun 2019 11:52:05 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     =?UTF-8?B?WmJ5bsSbaw==?= Kocur <zbynek.kocur@fel.cvut.cz>
Cc:     linux-iio@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>
Subject: Re: SRF04.c - wrong range for filter (line 145)
Message-ID: <20190622115205.767777c2@archlinux>
In-Reply-To: <B08A7378-8CBD-4B77-B18D-B0C157FAEC07@fel.cvut.cz>
References: <B08A7378-8CBD-4B77-B18D-B0C157FAEC07@fel.cvut.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+CC Andreas.

On Mon, 17 Jun 2019 21:21:37 +0200
Zbyněk Kocur <zbynek.kocur@fel.cvut.cz> wrote:

> Hello,
> 
> I try to use linux kernel module for proximity sensor SRF04 and i was not able to measure distance longer than 1.5 m. The problem is on implementation maximum range filter in function srf04_read, line 145. The reasoning assumes that the distance to 3 meters is limited, but the direction back and forth is neglected. Therefore, the resulting limit is a maximum of 1.5 meres and not a required 3 meters. The solution is to come out of the formula:
> 
>                  *         distance       2 * 3 m
>                  * time = ---------- = --------- = 18808777 ns
>                  *          speed       319 m/s
>                  *
> 
> 
> Best Regards,
> Zbyněk Kocur
> ---
> email: zbynek.kocur@fel.cvut.cz
> phone: +420 224 354 054
> web: http://www.fel.cvut.cz
> Department of Telecommunications Engineering
> Faculty of Electrical Engineering
> 

