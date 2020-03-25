Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C12192F7A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCYRi3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 13:38:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36381 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgCYRi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 13:38:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id j29so1488927pgl.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2020 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Ihn/nHmNsSbdocoF+ayFqwLa+S+n+8kJFwkqAtaNQs=;
        b=qWV/aBgJUNDvxc7vsFVE2EGd8cG+x0PQx01KzYGEseWVkMCvKmy7xhNwkA56JXAy1D
         scSriCdxMa5CV0lT7+wM3Ek2uzjamnLUPh3bWSLgTGBJUUaQ+Ba0lnNMuNcoXEVFNB4X
         E8OIyhi9honEBgsJn/UgdnTqH2PslgOpYFzg0ajSFnZpf5oBIQQtFh9DviA71/yuFUX6
         TYjpuL8hdADUPAVcY+jd+PP7A8yQCKdbkGyFCktmLFgtG4iTQrY2GmHw+mGQtc/fxtde
         jfDntb70c4cdd4o1pfHRre6qrs6qEG7fvJsYdW/hryQpiuZ7ffbXVMlY0na3gXQXfLON
         Zu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Ihn/nHmNsSbdocoF+ayFqwLa+S+n+8kJFwkqAtaNQs=;
        b=Wuxx7qNqo7ZPE1hVvyEDRhDrJkpizgwGPAw2zEsCbOg5pFemFytVm/I2KwQrMTLayu
         C+LLqcDtQS9BH9nZnHer52wkot+JcuDCZLhW7tU/MpzPufMUmm3G5cLHXnUJV2FFPlIN
         0x3W8CXxlwa+QUBtQmITMLsNwXHkW/Prp7Ra1TecbkOU4iwRn7UnTpUmV3aYF4MjxiG+
         R6tttDbkizQQi17hIr0vftnUUXDIUFXTySPbtQIbdfEDSrYx9Qa41EwR9Rbny/zH+Tqu
         7IQ0jLoVRD0v5xgrFlr8+7+K7fZg3QyFzzeUmf0BPsL24FbwozPz8ctKib9v7gntHIuH
         /IOw==
X-Gm-Message-State: ANhLgQ2xzyVa1r7MYQ880YI+asaN3JbRpr77mhHK0fYT0sCX6JGu8w48
        R1p9y25gBMZRomC01vSUvaE=
X-Google-Smtp-Source: ADFU+vuWskJaWyRvb2pCYcKWbYaP86si+zyLDNyUmFm/B9xklZ8nS2kCIrGC+Qb+H+UQR/f0T3wMFQ==
X-Received: by 2002:aa7:94a6:: with SMTP id a6mr4533071pfl.214.1585157906864;
        Wed, 25 Mar 2020 10:38:26 -0700 (PDT)
Received: from deeUbuntu ([103.228.147.248])
        by smtp.gmail.com with ESMTPSA id o12sm4906144pjt.16.2020.03.25.10.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 10:38:26 -0700 (PDT)
Date:   Wed, 25 Mar 2020 23:08:17 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
Message-ID: <20200325173815.GA28246@deeUbuntu>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
 <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
 <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com>
 <20200323014935.48048405@elisabeth>
 <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
 <20200323131531.1d6c8f93@elisabeth>
 <20200323175223.GC22110@deeUbuntu>
 <4385dc0509f035bbd14d85b81527997f7a2538e8.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <4385dc0509f035bbd14d85b81527997f7a2538e8.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2020 at 08:06:34AM +0000, Ardelean, Alexandru wrote:
> On Mon, 2020-03-23 at 23:22 +0530, DEEPAK VARMA wrote:
> > [External]
> > 
> > On Mon, Mar 23, 2020 at 01:15:31PM +0100, Stefano Brivio wrote:
> > > On Mon, 23 Mar 2020 11:28:52 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > 
> > > > On Mon, Mar 23, 2020 at 2:49 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > > > On Mon, 23 Mar 2020 01:44:20 +0200
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > > > On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > wrote:  
> > > > > > > Current implementation of the function
> > > > > > > ad7192_get_available_filter_freq
> > > > > > > repeats calculation of output data rate a few times. We can simplify
> > > > > > > these steps by refactoring out the calculation of fADC. This would
> > > > > > > also
> > > > > > > addresses the checkpatch warning of line exceeding 80 character.  
> > > > > > 
> > > > > > I'm not sure you did an equivalent changes. I believe in the original
> > > > > > code precision is better. Consider low clock frequencies when 10 bit
> > > > > > right shift may hide some bits of the division.  
> > > > > 
> > > > > Note that those bits are eventually "hidden" in the same way later,  
> > > > 
> > > > Even if mathematically (arithmetically) evaluation is correct, we have
> > > > to remember that computers are bad with floating point and especially
> > > > kernel, which uses integer arithmetic. That said, it's easy to get
> > > > off-by-one error (due to precision lost) if we do big division before
> > > > (not so big) multiplication.
> > > 
> > > That's exactly the point I was trying to explain below: swapping steps
> > > in a sequence of DIV_ROUND_CLOSEST() (*not* of arithmetic divisions),
> > > *should* not affect quantisation ("off-by-one") error.
> > > 
> > > I'm not entirely sure in this case, so a quick "demonstration" in
> > > Python or suchlike as you suggested would be nice to have, indeed.
> > > 
> > > > > despite the different sequence, due to DIV_ROUND_CLOSEST() being used
> > > > > at every step (both before and after the change) without other
> > > > > operations occurring.  
> > > > 
> > > > By the way, where AD7192_SINC3_FILTER and AD7192_SINC4_FILTER
> > > > multiplications disappear and why?
> > > 
> > > Those were in fact divisions (multiplications of the divisor). Overall,
> > > these steps are now arranged in a way closer to how they are presented
> > > in the datasheet mentioned here (up to "Chop Enabled" paragraph, page
> > > 26).
> > > 
> > 
> > Thank you Andy and Stefano for your comments. Its very thoughtful. I am
> > not much familiar with Python so far, but thinking on evaluating your
> > suggestion in a sample c program. I will share the outcome shortly.
> 
> +adding Mircea Caprioru
> 
> Umm, this math-cleanup looks pretty dangerous.
> If possible, I wouldn't change it.
> At least without some testing on HW.
> 
> Maybe doing math-simulations in Python scripts would also work, but not sure.
> 

Hello All,
I further reviewed current and proposed implementation of the
get_filter_freq() function[Thank you Stefano for your time]. We realised that I
was wrong in swapping DIV_ROUND_CLOSEST calls with mixing
multiplication in it. It is indeed incorrect to mix multiplication if we
want to reorder the calls. Comparison of the results from current and
proposed implementation proved it. In short, the patch I sent is wrong.
My apologies for any trouble.

We have further improved the test program with a revised implementation
[attached with this email] and found that this revision appears to
provide more accurate results [I think].

May I please request you to review the attached test program, verify the
results and share your feedback.

Thank you for your patience and the opportunity to learn a few new
things!

Deepak.

> > 
> > Deepak.
> > 
> > 
> > > -- 
> > > Stefano
> > > 

--oyUTqETQ0mS9luUI
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test_adc_freq.c"

#include <stdio.h>
#include <string.h>
#include <math.h>

#define AD7192_MODE_RATE(x)     ((x) & 0x3FF)
#define AD7192_NO_SINC_FILTER   1
#define AD7192_SINC3_FILTER     3
#define AD7192_SINC4_FILTER     4
#define AD7192_EXT_FREQ_MHZ_MIN 2457600
#define AD7192_EXT_FREQ_MHZ_MAX 5120000
#define AD7192_INT_FREQ_MHZ     4915200

#define DIV_ROUND_CLOSEST(x, divisor)(			\
{							\
	typeof(x) __x = x;				\
	typeof(divisor) __d = divisor;			\
	(((typeof(x))-1) > 0 ||				\
	((typeof(divisor))-1) > 0 ||			\
	(((__x) > 0) == ((__d) > 0))) ?			\
		(((__x) + ((__d) / 2)) / (__d)) :	\
		(((__x) - ((__d) / 2)) / (__d));	\
}							\
)

struct adc7192_state {
	unsigned int mode;
	unsigned int fclk;
};

/* ***
 * Current implementation 
 * ***
 */
void old_func_get_freq(struct adc7192_state *st, int *freq)
{
	unsigned int fadc;

	/* Formulas for filter at page 25 of the datasheet */
	fadc = DIV_ROUND_CLOSEST(st->fclk,
			AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);

	fadc = DIV_ROUND_CLOSEST(st->fclk,
			AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);

	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
}

/* ***
 * Proposed implementation 
 * ***
 */
void new_func_get_freq(struct adc7192_state *st, int *freq)
{
	/* Formulas for filter at page 25 of the datasheet */
	freq[0] = DIV_ROUND_CLOSEST(st->fclk * 240, AD7192_MODE_RATE(st->mode) *
						    AD7192_SINC4_FILTER * 1024);
	freq[1] = DIV_ROUND_CLOSEST(st->fclk * 240, AD7192_MODE_RATE(st->mode) *
						    AD7192_SINC3_FILTER * 1024);
	freq[2] = DIV_ROUND_CLOSEST(st->fclk * 230, AD7192_MODE_RATE(st->mode) *
						    1024);
	freq[3] = DIV_ROUND_CLOSEST(st->fclk * 272, AD7192_MODE_RATE(st->mode) *
						    1024);
}


/* ***
 * sample function using floats to demonstrate accuracy of new results 
 * ***
 */
void test(struct adc7192_state *st, float *freq)
{
	freq[0] = (float)st->fclk * 240 /
		  (AD7192_MODE_RATE(st->mode) * AD7192_SINC4_FILTER * 1024);
	freq[1] = (float)st->fclk * 240 /
		  (AD7192_MODE_RATE(st->mode) * AD7192_SINC3_FILTER * 1024);
	freq[2] = (float)st->fclk * 230 /
		  (AD7192_MODE_RATE(st->mode) * 1024);
	freq[3] = (float)st->fclk * 272 /
		  (AD7192_MODE_RATE(st->mode) * 1024);
}

int main(void)
{
	struct adc7192_state st;
	int o[4], n[4], i, j;
	float f[4];

	for (i = AD7192_EXT_FREQ_MHZ_MIN; i < AD7192_EXT_FREQ_MHZ_MAX; i++) {
		st.fclk = i;
		for (j = 1; j < 1023; j++) {
			st.mode = j;
			old_func_get_freq(&st, o);
			new_func_get_freq(&st, n);

			if (memcmp(o, n, sizeof(o))) {
				printf("fclk: %d, mode: %d\n", i, j);
				printf("old: %i %i %i %i\n",
					o[0], o[1], o[2], o[3]);
				printf("new: %i %i %i %i\n",
					n[0], n[1], n[2], n[3]);

				test(&st, f);
				printf("float: %f %f %f %f\n",
					f[0], f[1], f[2], f[3]);

				if (fabs(f[0] - n[0]) <= fabs(f[0] - o[0]) &&
				    fabs(f[1] - n[1]) <= fabs(f[1] - o[1]) &&
				    fabs(f[2] - n[2]) <= fabs(f[2] - o[2]) &&
				    fabs(f[3] - n[3]) <= fabs(f[3] - o[3]))
					printf("  improvement\n");
				else
					return 1;
			}

		}
	}

	return 0;
}

--oyUTqETQ0mS9luUI--
