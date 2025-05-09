Return-Path: <linux-iio+bounces-19398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF237AB1B1C
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A6B188BF08
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC712367CD;
	Fri,  9 May 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNm2stu/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1E23498E
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809898; cv=none; b=a+0TmfDHaIcR1JifzW3jH+sUK2DHUM0cHKLbsMddnAbJ6u0wBH8aNikK7ugoYuWSWP49W7qMrI9j1ioyMWU6AddrInAWQzqxiaAhhmqa6HVqQKgkIQF4N1jg6YioWYeHPQSu9FcTomvE//HMZnq61NVGErKPCFgvywbr/ev9y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809898; c=relaxed/simple;
	bh=Iw61ed2/GsjkCH+N33Xwb6epE7eFkvL+PROIpHj6aXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBH22oyB49SMvvkRTp7Hvn2NDSxv7lEm+RU49XcNmR/4VAGcicGKJlBHKFmkMCXYp8ElHo3vfEu/ZeBfZQSxTiMg2arqp7L765d+2nyZTLIobhj6WMdUerXIoV2qa3wLVRuAdHsX/AvRL6VFaWAaPYwQenrEkI6I9UqKvOp9uqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNm2stu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71D3C4CEE4;
	Fri,  9 May 2025 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746809896;
	bh=Iw61ed2/GsjkCH+N33Xwb6epE7eFkvL+PROIpHj6aXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNm2stu/Gr63GwVL84dXey0X6sWUBARAdzdQdZQo/KHK7kmrFwkQxfy7J4/GjVI/w
	 g/Pkz+wc3oba9lZVwOS0gzvU0dRtjGzRoYVM/zCoOUgwH3CLBQ06xjR00UC0rZyfbi
	 pgKrLb7hYY3lonk4kQ5AjzwXcZZGcN4N8Vf8iO2QDjW4ufmzHmtWnd/q+YQGb2s63y
	 w/NkuVM8oYjkhKlDWf/DSR1juLgDJ9YhtwzzfY1Xmps2y0BKshWemtrygtLIrfaeTj
	 9xnSgglutx3ok1ipKsMu7S/teWK+WKhus35V70Idee4YlHcX2uMpniuIuIkWOgMSNm
	 jLjSKLtiN6svQ==
Date: Fri, 9 May 2025 09:58:13 -0700
From: Kees Cook <kees@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
Message-ID: <202505090942.48EBF01B@keescook>
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
 <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
 <aBpWXB8c8RSjYBtD@stanley.mountain>
 <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>
 <aBsOqAI0efLHGbeA@stanley.mountain>
 <b85aa946-aa5f-40aa-8d22-19a9d916f5a0@baylibre.com>
 <aB2Xam2JQ_eU9Bat@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB2Xam2JQ_eU9Bat@stanley.mountain>

On Fri, May 09, 2025 at 08:49:30AM +0300, Dan Carpenter wrote:
> Let me add Kees to the CC list because he'll want to know this as well.
> 
> On Wed, May 07, 2025 at 08:33:07AM -0500, David Lechner wrote:
> > On 5/7/25 2:41 AM, Dan Carpenter wrote:
> > > On Wed, May 07, 2025 at 07:35:27AM +0100, Jonathan Cameron wrote:
> > >>
> > >>
> > >> On 6 May 2025 19:35:08 BST, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >>> On Tue, May 06, 2025 at 09:25:00AM -0500, David Lechner wrote:
> > >>>> On 5/6/25 7:32 AM, Dan Carpenter wrote:
> > >>>>> Hello David Lechner,
> > >>>>>
> > >>>>> Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> > >>>>> from Apr 22, 2025 (linux-next), leads to the following Smatch static
> > >>>>> checker warning:
> > >>>>>
> > >>>>> 	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
> > >>>>> 	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')
> > >>>>>
> > >>>>> drivers/iio/pressure/bmp280-core.c
> > >>>>>     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
> > >>>>>     1226 {
> > >>>>>     1227         struct iio_poll_func *pf = p;
> > >>>>>     1228         struct iio_dev *indio_dev = pf->indio_dev;
> > >>>>>     1229         struct bmp280_data *data = iio_priv(indio_dev);
> > >>>>>     1230         u32 adc_temp, adc_press, adc_humidity;
> > >>>>>     1231         s32 t_fine;
> > >>>>>     1232         struct {
> > >>>>>     1233                 u32 comp_press;
> > >>>>>     1234                 s32 comp_temp;
> > >>>>>     1235                 u32 comp_humidity;
> > >>>>>     1236                 aligned_s64 timestamp;
> > >>>>>
> > >>>>> There is a 4 byte hole between comp_humidity and timestamp.
> > >>>>
> > >>>> Yes, this was the intention of this patch.
> > >>>>
> > >>>>>
> > >>>>>     1237         } buffer;
> > >>>>>     1238         int ret;
> > >>>>>     1239 
> > >>>>
> > >>>> ...
> > >>>>
> > >>>>>     1279 
> > >>>>> --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
> > >>>>>                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> > >>>>> So I believe it leads to an information leaks here.
> > >>>>
> > >>>> Aha, so we should e.g. do memset() to fill the hole first.
> > >>>>
> > >>>
> > >>> That works, or you could initialize it with = { }.
> > >>
> > >> I tried to track this down the other day.
> > >> What are compilers guaranteeing around
> > >> that vs { 0 }  and holes?  The c spec has only recently standardised on { }.
> > >>
> > >> I'd love to stop using memset for these.
> > > 
> > > The rule in the C standard is that if the initializer sets every struct
> > > member then it will NOT zero out struct holes.  But if there are any
> > > unset struct members then the holes are zeroed.  So = { } will always
> > > work.  You really have to try hard to invent a scenario where = { 0 }
> > > won't fill the struct holes (a one member struct with a weird alignment).
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > I was curious about this too and came across a blog post [1] that claims that
> > with clang compiler and certain optimization levels, { } and { 0 } still aren't
> > good enough, which is why I went with the memset().
> > 
> > [1]: https://interrupt.memfault.com/blog/c-struct-padding-initialization
> 
> Huh...
> 
> "Strategy 2, explicitly setting each struct member".  This isn't
> "supposed" to initialize struct holes according to the C current
> standard.
> 
> It's discouraging that = { 0 } and { } don't work.  -O1 is not supported
> in the kernel so that's not an emergency.  I don't know about -Os?

tl;dr: Use { }.

I didn't think -Os was supported either?

The stackinit KUnit tests will do all these checks, FWIW. It's a little
difficult to decode the results, but this is consistent with the
findings. Looking at a similar case to above, the "small_hole" struct
test:

struct test_small_hole {
        size_t one;
        char two;
        /* 3 byte padding hole here. */
        int three;
        unsigned long four;
};

Tested with various initializers:

#define INIT_STRUCT_none(var_type)      /**/
#define INIT_STRUCT_zero(var_type)      = { }
#define INIT_STRUCT_old_zero(var_type)  = { 0 }

#define __static_partial                { .two = 0, }
#define __static_all                    { .one = 0, \
                                          .two = 0, \
                                          .three = 0, \
                                          .four = 0, \
                                        }
#define __dynamic_partial               { .two = arg->two, }
#define __dynamic_all                   { .one = arg->one, \
                                          .two = arg->two, \
                                          .three = arg->three, \
                                          .four = arg->four, \
                                        }
#define __runtime_partial               var.two = 0
#define __runtime_all                   var.one = 0; \
                                        var.two = 0; \
                                        var.three = 0; \
                                        var.four = 0


We can see a default build (-O2), "PASSED" means all zero, and "SKIPPED"
means "not all zero, but we expected that given the Kconfig involved":

(Running "./tools/testing/kunit/kunit.py run stackinit")

[09:44:47] [PASSED] test_small_hole_zero
[09:44:47] [PASSED] test_small_hole_old_zero
[09:44:47] [PASSED] test_small_hole_dynamic_partial
[09:44:47] [PASSED] test_small_hole_assigned_dynamic_partial
[09:44:47] [PASSED] test_small_hole_static_partial
[09:44:47] [PASSED] test_small_hole_assigned_static_partial

These are "= { }", "= { 0 }", and partial member initialization.

[09:44:47] [SKIPPED] test_small_hole_static_all
[09:44:47] [SKIPPED] test_small_hole_assigned_static_all
[09:44:47] [SKIPPED] test_small_hole_dynamic_all
[09:44:47] [SKIPPED] test_small_hole_assigned_dynamic_all

These are the full member initialization, which, yes, leaves the padding
uninitialized. :(

[09:44:47] [SKIPPED] test_small_hole_runtime_partial
[09:44:47] [SKIPPED] test_small_hole_runtime_all

These set members from runtime values instead of static values, and
padding is left uninitialized.

[09:44:47] [SKIPPED] test_small_hole_none

No init, obviously left uninitialized

[09:44:47] [PASSED] test_small_hole_assigned_copy

This is a full object copy (from a source with initialized padding),
so the result is also initialized.

Building with CONFIG_INIT_STACK_ALL_ZERO=y changes all this, of course.
In that case, everything passes:

./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y stackinit


-- 
Kees Cook

